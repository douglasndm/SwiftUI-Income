//
//  AddTransactionView.swift
//  Income
//
//  Created by Douglas de Mattos on 12/04/25.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State private var amount: Double = 0.0;
    @State private var transactionTitle: String = "";
    @State private var selectedTransactionType: TransactionType = .expense;
    
    @State private var alertTitle = "";
    @State private var alertMessage = "";
    @State private var showAlert: Bool = false;
    
    @Binding var transactions: [Transaction];
    @Environment(\.dismiss) var dismiss;
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        
        return numberFormatter;
    }
    
    var body: some View {
        VStack {
            TextField("0,00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad);
            
           Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.Title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top);
            
            Button {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title";
                    alertMessage = "Title must be 2 or more characters long";
                    showAlert = true;
                    return;
                }
                
                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date());
                
                transactions.append(transaction);
                dismiss();
            } label: {
                Text("Create")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top)
            .padding(.horizontal, 30)

            
            Spacer();
        }
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("Ok")
            }

        } message: {
            Text(alertMessage);
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]));
}
