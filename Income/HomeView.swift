//
//  ContentView.swift
//  Income
//
//  Created by Douglas de Mattos on 01/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transacations: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date())
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transacations) { transacation in
                    VStack {
                        HStack {
                            Spacer();
                            Text(transacation.displayDate)
                                .font(.system(size: 14));
                            Spacer();
                        }
                        .padding(.vertical, 5)
                        .background(Color.lightGrayShade.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        HStack {
                            Image(systemName: transacation.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(transacation.type == .income ? .red : .blue);
                            
                            VStack (alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(transacation.title)
                                        .font(.system(size: 15, weight: .bold))
                                    Spacer();
                                    Text(String(transacation.displayAmount))
                                        .font(.system(size: 15, weight: .bold))
                                };
                                Text("Completed")
                                    .font(.system(size: 14))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
