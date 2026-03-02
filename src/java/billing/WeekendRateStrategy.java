/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package billing;

import model.BillData;
import model.BillResult;

import java.math.BigDecimal;

public class WeekendRateStrategy implements BillingStrategy {

    private final BigDecimal weekendMultiplier; // e.g. 1.20

    public WeekendRateStrategy(BigDecimal weekendMultiplier) {
        this.weekendMultiplier = weekendMultiplier;
    }

    @Override
    public BillResult calculate(BillData data) {
        BillResult r = new BillResult();
        r.setStrategyName(name());

        long weekendNights = data.getWeekendNights();
        long weekdayNights = data.getTotalNights() - weekendNights;

        r.setWeekendNights(weekendNights);
        r.setWeekdayNights(weekdayNights);

        BigDecimal weekdayTotal = data.getRate().multiply(BigDecimal.valueOf(weekdayNights));
        BigDecimal weekendRate = data.getRate().multiply(weekendMultiplier);
        BigDecimal weekendTotal = weekendRate.multiply(BigDecimal.valueOf(weekendNights));

        BigDecimal subtotal = weekdayTotal.add(weekendTotal);

        r.setSubtotal(subtotal);
        r.setDiscountAmount(BigDecimal.ZERO);
        r.setTotal(subtotal);
        return r;
    }

    @Override
    public String name() {
        return "Weekend Rate (" + weekendMultiplier + "x)";
    }
}