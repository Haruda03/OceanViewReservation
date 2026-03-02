/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package billing;

import model.BillData;
import model.BillResult;

import java.math.BigDecimal;

public class NormalRateStrategy implements BillingStrategy {

    @Override
    public BillResult calculate(BillData data) {
        BillResult r = new BillResult();
        r.setStrategyName(name());
        r.setWeekdayNights(data.getTotalNights());
        r.setWeekendNights(0);

        BigDecimal subtotal = data.getRate().multiply(BigDecimal.valueOf(data.getTotalNights()));
        r.setSubtotal(subtotal);
        r.setDiscountAmount(BigDecimal.ZERO);
        r.setTotal(subtotal);
        return r;
    }

    @Override
    public String name() {
        return "Normal Rate";
    }
}