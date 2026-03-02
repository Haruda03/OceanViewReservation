/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package billing;

import model.BillData;
import model.BillResult;

public interface BillingStrategy {
    BillResult calculate(BillData data);
    String name();
}