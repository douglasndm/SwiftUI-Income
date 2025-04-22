//
//  Currency.swift
//  Income
//
//  Created by Douglas de Mattos on 18/04/25.
//
import Foundation;

enum Currency: Int, CaseIterable {
    case usd, pounds;
    
    var title: String {
        switch self {
            case .usd:
                "USD"
            case .pounds:
                "GBP"
        }
    }
    
    var locale: Locale {
        switch self {
            case .usd:
                return Locale(identifier: "en_US");
            
            case .pounds:
                return Locale(identifier: "en_GB");
            
        }
    }
}
