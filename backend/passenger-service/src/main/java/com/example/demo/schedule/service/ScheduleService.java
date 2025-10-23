package com.example.demo.schedule.service;

import com.example.demo.model.Bus;
import com.example.demo.model.Route;
import com.example.demo.model.Trip;
import com.example.demo.schedule.dto.ScheduleResponseDto;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

@Service
public class ScheduleService {

    private final Firestore dbFirestore = FirestoreClient.getFirestore();

    /**
     * Fetches all routes and compiles a unique list of all stop names.
     */
    public List<String> getAllLocations() throws ExecutionException, InterruptedException {
        Set<String> locations = new HashSet<>();
        List<QueryDocumentSnapshot> documents = dbFirestore.collection("routes").get().get().getDocuments();

        for (QueryDocumentSnapshot document : documents) {
            Route route = document.toObject(Route.class);
            locations.add(route.getStartLocation());
            locations.add(route.getEndLocation());
            if (route.getStops() != null) {
                locations.addAll(route.getStops());
            }
        }
        return new ArrayList<>(locations);
    }

    /**
     * Searches for scheduled trips based on start, end, and date.
     */
    public List<ScheduleResponseDto> searchSchedules(String startLocation, String endLocation, String date)
            throws ExecutionException, InterruptedException {

        // 1. Find all route IDs that match the start and end location
        List<String> matchingRouteIds = findMatchingRouteIds(startLocation, endLocation);
        if (matchingRouteIds.isEmpty()) {
            return Collections.emptyList(); // No routes found
        }

        // 2. Parse date and create timestamp range for the query
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        LocalDate localDate = LocalDate.parse(date, formatter);

        Date startOfDay = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endOfDay = Date.from(localDate.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

        // 3. Find trips for those routes on that day
        List<Trip> trips = dbFirestore.collection("trips")
                .whereIn("assignedRouteID", matchingRouteIds)
                .whereGreaterThanOrEqualTo("departureTimestamp", startOfDay)
                .whereLessThan("departureTimestamp", endOfDay)
                .get().get().toObjects(Trip.class);

        // 4. "Enrich" the trip data with details from other collections
        return enrichTrips(trips);
    }

    private List<String> findMatchingRouteIds(String userStart, String userEnd)
            throws ExecutionException, InterruptedException {

        List<String> matchingRouteIds = new ArrayList<>();
        // Get ALL routes from Firestore
        List<QueryDocumentSnapshot> allRouteDocuments = dbFirestore.collection("routes").get().get().getDocuments();

        for (QueryDocumentSnapshot document : allRouteDocuments) {
            Route route = document.toObject(Route.class);
            String routeId = document.getId();

            // Create the full path for the route including start, stops, and end
            List<String> fullPath = new ArrayList<>();
            fullPath.add(route.getStartLocation()); // Add official start
            if (route.getStops() != null) {
                fullPath.addAll(route.getStops()); // Add intermediate stops
            }
            fullPath.add(route.getEndLocation()); // Add official end

            // Find the index of the user's start and end points within the route path
            int startIndex = fullPath.indexOf(userStart);
            int endIndex = fullPath.indexOf(userEnd);

            // Check if BOTH locations exist on this route AND the start comes before the end
            if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
                matchingRouteIds.add(routeId);
            }
        }

        return matchingRouteIds;
    }

    private List<ScheduleResponseDto> enrichTrips(List<Trip> trips) throws ExecutionException, InterruptedException {
        List<ScheduleResponseDto> responseList = new ArrayList<>();
        SimpleDateFormat timeFormat = new SimpleDateFormat("hh.mm a");

        for (Trip trip : trips) {
            // Get Route details
            DocumentSnapshot routeDoc = dbFirestore.collection("routes").document(trip.getAssignedRouteID()).get().get();
            Route route = routeDoc.exists() ? routeDoc.toObject(Route.class) : new Route(); // Handle missing doc

            // Get Bus details
            DocumentSnapshot busDoc = dbFirestore.collection("buses").document(trip.getBusID()).get().get();
            Bus bus = busDoc.exists() ? busDoc.toObject(Bus.class) : new Bus(); // Handle missing doc

            // Build the response object for the Flutter app
            ScheduleResponseDto dto = new ScheduleResponseDto();
            dto.setRoute(route.getRouteName());
            dto.setStartLocation(route.getStartLocation());
            dto.setEndLocation(route.getEndLocation());
            dto.setBusNumber(bus.getBusNumber());

            if(trip.getDepartureTimestamp() != null) {
                dto.setStartTime(timeFormat.format(trip.getDepartureTimestamp()));
            }
            if(trip.getArrivalTimestamp() != null) {
                dto.setEndTime(timeFormat.format(trip.getArrivalTimestamp()));
            }

            responseList.add(dto);
        }
        return responseList;
    }
}
