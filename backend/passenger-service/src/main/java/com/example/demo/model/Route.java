package com.example.demo.model;

import com.google.cloud.firestore.annotation.IgnoreExtraProperties;
import java.util.List;

@IgnoreExtraProperties // Tells Firestore to ignore fields that are not here
public class Route {
    private String routeName;
    private String startLocation;
    private String endLocation;
    private List<String> stops;

    // Getters and Setters
    public String getRouteName() { return routeName; }
    public void setRouteName(String routeName) { this.routeName = routeName; }
    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }
    public String getEndLocation() { return endLocation; }
    public void setEndLocation(String endLocation) { this.endLocation = endLocation; }
    public List<String> getStops() { return stops; }
    public void setStops(List<String> stops) { this.stops = stops; }
}
