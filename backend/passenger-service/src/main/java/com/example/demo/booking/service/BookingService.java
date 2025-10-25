package com.example.demo.booking.service;

import com.example.demo.booking.dto.BookingResponseDto;
import com.example.demo.model.Bus;
import com.example.demo.model.Route;
import com.example.demo.model.Trip;
import com.google.api.core.ApiFuture;
import com.google.api.core.ApiFutures;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

@Service
public class BookingService {

    private final Firestore dbFirestore = FirestoreClient.getFirestore();
    private final SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");

    // Re-use logic from ScheduleService to find matching routes
    private List<String> findMatchingRouteIds(String userStart, String userEnd)
            throws ExecutionException, InterruptedException {
        // (Copy the updated findMatchingRouteIds method from ScheduleService here)
        List<String> matchingRouteIds = new ArrayList<>();
        List<QueryDocumentSnapshot> allRouteDocuments = dbFirestore.collection("routes").get().get().getDocuments();
        for (QueryDocumentSnapshot document : allRouteDocuments) {
            Route route = document.toObject(Route.class); String routeId = document.getId();
            List<String> fullPath = new ArrayList<>();
            fullPath.add(route.getStartLocation());
            if (route.getStops() != null) { fullPath.addAll(route.getStops()); }
            fullPath.add(route.getEndLocation());
            int startIndex = fullPath.indexOf(userStart); int endIndex = fullPath.indexOf(userEnd);
            if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) { matchingRouteIds.add(routeId); }
        }
        return matchingRouteIds;
    }

    public List<BookingResponseDto> searchBookableTrips(String startLocation, String endLocation, String date)
            throws ExecutionException, InterruptedException {

        List<String> matchingRouteIds = findMatchingRouteIds(startLocation, endLocation);
        if (matchingRouteIds.isEmpty()) {
            return Collections.emptyList();
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        LocalDate localDate = LocalDate.parse(date, formatter);
        Date startOfDay = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endOfDay = Date.from(localDate.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

        // 1. Find all trips matching routes and date
        List<QueryDocumentSnapshot> tripDocs = dbFirestore.collection("trips")
                .whereIn("assignedRouteID", matchingRouteIds)
                .whereGreaterThanOrEqualTo("departureTimestamp", startOfDay)
                .whereLessThan("departureTimestamp", endOfDay)
                .get().get().getDocuments(); // Get documents with IDs

        if (tripDocs.isEmpty()) {
            return Collections.emptyList();
        }

        List<BookingResponseDto> results = new ArrayList<>();
        List<ApiFuture<DocumentSnapshot>> busFutures = new ArrayList<>();
        List<ApiFuture<DocumentSnapshot>> routeFutures = new ArrayList<>();
        List<Trip> trips = new ArrayList<>();
        List<String> tripIds = new ArrayList<>(); // Store trip IDs

        // Prepare futures to fetch related Bus and Route data efficiently
        for (QueryDocumentSnapshot tripDoc : tripDocs) {
            Trip trip = tripDoc.toObject(Trip.class);
            trips.add(trip);
            tripIds.add(tripDoc.getId()); // Store the document ID
            busFutures.add(dbFirestore.collection("buses").document(trip.getBusID()).get());
            routeFutures.add(dbFirestore.collection("routes").document(trip.getAssignedRouteID()).get());
        }

        // Wait for all Bus and Route fetches to complete
        List<DocumentSnapshot> busSnapshots = ApiFutures.allAsList(busFutures).get();
        List<DocumentSnapshot> routeSnapshots = ApiFutures.allAsList(routeFutures).get();

        // 2. Process results and FILTER by busType
        for (int i = 0; i < trips.size(); i++) {
            Trip trip = trips.get(i);
            DocumentSnapshot busDoc = busSnapshots.get(i);
            DocumentSnapshot routeDoc = routeSnapshots.get(i);

            if (busDoc.exists() && routeDoc.exists()) {
                Bus bus = busDoc.toObject(Bus.class);
                Route route = routeDoc.toObject(Route.class);

                // --- FILTERING LOGIC ---
                if (bus != null && "Intercity".equalsIgnoreCase(bus.getBusType())) {
                    // --- END FILTERING LOGIC ---

                    BookingResponseDto dto = new BookingResponseDto();
                    dto.setTripId(tripIds.get(i)); // Add the Trip Document ID
                    dto.setRoute(route.getRouteName());
                    dto.setStartLocation(route.getStartLocation()); // Show route start/end
                    dto.setEndLocation(route.getEndLocation());
                    dto.setBusNumber(bus.getBusNumber());
                    dto.setBusType(bus.getBusType());
                    dto.setAvailableSeats(trip.getAvailableSeats());
                    if (trip.getDepartureTimestamp() != null) {
                        dto.setDepartureTime(timeFormat.format(trip.getDepartureTimestamp()));
                    }
                    if (trip.getArrivalTimestamp() != null) {
                        dto.setArrivalTime(timeFormat.format(trip.getArrivalTimestamp()));
                    }
                    results.add(dto);
                }
            }
        }
        return results;
    }
}