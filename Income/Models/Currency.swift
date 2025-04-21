//
//  Currency.swift
//  Income
//
//  Created by Douglas de Mattos on 18/04/25.
//

enum Currency: CaseIterable {
    case usd, pounds;
    
    var title: String {
        switch self {
            case .usd:
                "USD"
            case .pounds:
                "GBP"
        }
    }
}
