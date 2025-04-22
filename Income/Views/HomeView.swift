//
//  ContentView.swift
//  Income
//
//  Created by Douglas de Mattos on 01/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transacations: [Transaction] = [];
    
    @State private var showAddTransactionView: Bool = false;
    @State private var transacationToEdit: Transaction?;
    @State private var showSettings = false;
    
    @AppStorage("orderDescending") var orderDescending = false;
    
    private var displayTransactions: [Transaction] {
        let sortedTransactions = orderDescending ? transacations.sorted(by: {
            $0.date < $1.date
        }) : transacations.sorted(by: { $0.date > $1.date })
        
        return sortedTransactions;
    }
    
    private var expenses: String {
        let sumExpenses = transacations.filter({ $0.type == .expense }).reduce(0, {
            $0 + $1.amount
        });
            
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "R$ 0,00";
    }
    
    private var incomes: String {
        let sumIncomes = transacations.filter({ $0.type == .income }).reduce(0, { $0 + $1.amount });
        
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        
        return numberFormatter.string(from: sumIncomes as NSNumber) ?? "R$ 0,00";
    }
    
    var balance: String {
        let sumExpenses = transacations.filter({ $0.type == .expense }).reduce(0, { $0 + $1.amount });
        let sumIncomes = transacations.filter({ $0.type == .income }).reduce(0, { $0 + $1.amount });
        
        let total = sumIncomes - sumExpenses;
        
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        
        return numberFormatter.string(from: total as NSNumber) ?? "R$ 0,00";
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer();
            NavigationLink {
                AddTransactionView(transactions: $transacations);
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 7);
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle());
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen);
            
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white);
                        
                        Text(balance)
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white);
                    }
                    Spacer();
                }
                .padding(.top)
                
                HStack (spacing: 25) {
                    VStack (alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white);
                        Text(expenses)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white);
                    }
                    
                    VStack (alignment: .leading){
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white);
                        Text(incomes)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white);
                    }
                }
                Spacer()
            }.padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5.0)
        .frame(height: 150)
        .padding(.horizontal);
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView();
                    
                    List {
                        ForEach(displayTransactions) { transaction in
                            Button(action: {
                                transacationToEdit = transaction;
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black);
                            })
                        }
                        .onDelete(perform: delete)
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                }
                
                FloatingButton();
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transacationToEdit, destination: { transaction in
                AddTransactionView(transaction: transaction, transactions: $transacations);
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView(transactions: $transacations);
            })
            .sheet(isPresented: $showSettings, content: {
                SettingsView();
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSettings = true;
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.black);
                    })
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        transacations.remove(atOffsets: offsets);
    }
}

#Preview {
    HomeView()
}
