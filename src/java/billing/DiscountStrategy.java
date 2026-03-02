/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package billing;

import model.BillData;
import model.BillResult;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class DiscountStrategy implements BillingStrategy {

    private final BigDecimal discountPercent; // e.g. 10 = 10%

    public DiscountStrategy(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    @Override
    public BillResult calculate(BillData data) {
        BillResult r = new BillResult();
        r.setStrategyName(name());
        r.setWeekdayNights(data.getTotalNights());
        r.setWeekendNights(0);

        BigDecimal subtotal = data.getRate().multiply(BigDecimal.valueOf(data.getTotalNights()));

        BigDecimal discount = subtotal
                .multiply(discountPercent)
                .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

        BigDecimal total = subtotal.subtract(discount);

        r.setSubtotal(subtotal);
        r.setDiscountAmount(discount);
        r.setTotal(total);
        return r;
    }

    @Override
    public String name() {
        return "Discount (" + discountPercent + "%)";
    }
}