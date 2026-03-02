/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

public class BillResult {
    private String strategyName;
    private long weekdayNights;
    private long weekendNights;

    private BigDecimal subtotal;
    private BigDecimal discountAmount;
    private BigDecimal total;

    public String getStrategyName() { return strategyName; }
    public void setStrategyName(String strategyName) { this.strategyName = strategyName; }

    public long getWeekdayNights() { return weekdayNights; }
    public void setWeekdayNights(long weekdayNights) { this.weekdayNights = weekdayNights; }

    public long getWeekendNights() { return weekendNights; }
    public void setWeekendNights(long weekendNights) { this.weekendNights = weekendNights; }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }
}