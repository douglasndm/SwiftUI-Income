//
//  TransactionTypeModel.swift
//  Income
//
//  Created by Douglas de Mattos on 01/04/25.
//
import Foundation;

enum TransactionType: String, CaseIterable, Identifiable {
    case income
    case expense
    
    var id: Self { self }
    
    var Title: String {
        switch self {
            case .income:
                return "Income"
            case .expense:
                return "Expense"
        }
    }
}
