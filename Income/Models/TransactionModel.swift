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
}
