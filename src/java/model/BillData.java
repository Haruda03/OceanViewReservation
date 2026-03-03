/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;

public class BillData {
    private String reservationNo;
    private String roomType;
    private BigDecimal rate;
    private LocalDate checkIn;
    private LocalDate checkOut; // exclusive
    private int userId;
public int getUserId(){return userId;}
public void setUserId(int userId){this.userId=userId;}
    
    public String getReservationNo() { return reservationNo; }
    public void setReservationNo(String reservationNo) { this.reservationNo = reservationNo; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public BigDecimal getRate() { return rate; }
    public void setRate(BigDecimal rate) { this.rate = rate; }

    public LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(LocalDate checkIn) { this.checkIn = checkIn; }

    public LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(LocalDate checkOut) { this.checkOut = checkOut; }

    public long getTotalNights() {
        return java.time.temporal.ChronoUnit.DAYS.between(checkIn, checkOut);
    }

    // Counts nights where the NIGHT is Fri or Sat (common hotel weekend rule)
    public long getWeekendNights() {
        long weekend = 0;
        LocalDate d = checkIn;
        while (d.isBefore(checkOut)) {
            DayOfWeek dow = d.getDayOfWeek();
            if (dow == DayOfWeek.FRIDAY || dow == DayOfWeek.SATURDAY) {
                weekend++;
            }
            d = d.plusDays(1);
        }
        return weekend;
    }
}