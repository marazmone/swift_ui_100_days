//
//  AddView.swift
//  project_7
//
//  Created by user on 02.08.2022.
//

import Foundation
import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) private var dissmiss
    
    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD")).keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dissmiss()
                }
            }
        }
    }
}

struct AddView_Preview: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
