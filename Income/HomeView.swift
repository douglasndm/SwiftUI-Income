//
//  ContentView.swift
//  Income
//
//  Created by Douglas de Mattos on 01/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transacations: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date())
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transacations) { transaction in
                    TransactionView(transaction: transaction);
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    HomeView()
}
