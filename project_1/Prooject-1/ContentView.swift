//
//  ContentView.swift
//  Prooject-1
//
//  Created by Serhii Hulenko on 30.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    private let tipPersantages = [0, 10, 15, 20, 25]
    
    private var totalPerPerson: Double {
        if checkAmount == 0 {
            return 0
        }
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    private var originalAmount: Double {
        if totalPerPerson == 0 {
            return 0
        }
        
        return totalPerPerson * Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                 Section {
                     TextField("Amount", value: $checkAmount, format: currencyFormat)
                         .keyboardType(.decimalPad)
                         .focused($amountIsFocused)
                }
                Section {
                    Picker("NumberOfPeople", selection: $numberOfPeople) {
                        ForEach(2..<7) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                                    Text($0, format: .percent)
                                }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Text(originalAmount, format: currencyFormat)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
