//
//  TransactionModel.swift
//  Income
//
//  Created by Douglas de Mattos on 01/04/25.
//

import Foundation;

struct Transaction: Identifiable {
    let id = UUID();
    let title: String;
    let type: TransactionType;
    let amount: Double;
    let date: Date;
    
    var displayDate: String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = .medium;
        return dateFormatter.string(from: date);
    }
    
    var displayAmount: String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        numberFormatter.maximumFractionDigits = 2;
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00";
    }
}
