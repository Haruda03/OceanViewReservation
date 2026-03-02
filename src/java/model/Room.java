/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

public class Room {

    private int roomId;
    private String roomType;
    private BigDecimal rate;
    private int maxGuests;
    private String status;      // ACTIVE / INACTIVE

    // NEW: Real resort fields
    private String photoUrl;    // URL or local path
    private String description; // short description
    private String amenities;   // comma-separated list

    public Room() {}

    public Room(int roomId, String roomType, BigDecimal rate, int maxGuests, String status,
                String photoUrl, String description, String amenities) {
        this.roomId = roomId;
        this.roomType = roomType;
        this.rate = rate;
        this.maxGuests = maxGuests;
        this.status = status;
        this.photoUrl = photoUrl;
        this.description = description;
        this.amenities = amenities;
    }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public BigDecimal getRate() { return rate; }
    public void setRate(BigDecimal rate) { this.rate = rate; }

    public int getMaxGuests() { return maxGuests; }
    public void setMaxGuests(int maxGuests) { this.maxGuests = maxGuests; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    // fallback if photo_url is empty
    public String safePhoto() {
        if (photoUrl == null || photoUrl.trim().isEmpty()) {
            return "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=1600&q=80";
        }
        return photoUrl.trim();
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomId=" + roomId +
                ", roomType='" + roomType + '\'' +
                ", rate=" + rate +
                ", maxGuests=" + maxGuests +
                ", status='" + status + '\'' +
                ", photoUrl='" + photoUrl + '\'' +
                ", description='" + description + '\'' +
                ", amenities='" + amenities + '\'' +
                '}';
    }
}