package model;

import java.sql.Timestamp;

public class Notification {
    private int notifId;
    private Integer userId; // null if meant for all staff, or 0
    private String message;
    private boolean isRead;
    private Timestamp createdAt;

    public int getNotifId() {
        return notifId;
    }

    public void setNotifId(int notifId) {
        this.notifId = notifId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
