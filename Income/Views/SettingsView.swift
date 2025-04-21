//
//  SettingsView.swift
//  Income
//
//  Created by Douglas de Mattos on 18/04/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var orderDescending: Bool = false;
    @State private var currency: Currency = .usd;
    @State private var filterMinimun: Double = 0.0;
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        
        return numberFormatter;
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Toggle(isOn: $orderDescending) {
                        Text("Order \(orderDescending ? "(Earliest)" : "(Latest)")");
                    }
                }
                
                HStack {
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.title);
                        }
                    }
                }
                
                HStack {
                    Text("Filter Minimum");
                    TextField("", value: $filterMinimun, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing);
                }
                
            }.navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
