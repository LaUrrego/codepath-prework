//
//  tipCalculator.swift
//  Prework
//
//  Created by Larry Urrego on 7/26/22.
//
//  File for TipCalculator class to handle all variables 
import Foundation
class TipCalculator {
    var billTotal: Double = 0
    var preTipBill: Double = 0
    var tipPercentage: Double = 0
    var tipTotal: Double = 0
    
    init(preTipBill: Double, tipPercentage: Double) {
        self.preTipBill = preTipBill
        self.tipPercentage = tipPercentage
    }
    
    func calculateTotal() {
        tipTotal = preTipBill * tipPercentage
        billTotal = tipTotal + preTipBill
    }
    
}
