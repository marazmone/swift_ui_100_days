//
//  ContentView.swift
//  project_4
//
//  Created by Serhii Hulenko on 12.07.2022.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 3
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        let bindingWake = Binding(
            get: { wakeUp },
            set: {
                wakeUp = $0
                calculateBedtime()
            }
        )
        let bindingSleepAmount = Binding(
            get: { sleepAmount },
            set: {
                sleepAmount = $0
                calculateBedtime()
            }
        )
        let bindingCoffeeAmount = Binding(
            get: { coffeeAmount },
            set: {
                coffeeAmount = $0
                calculateBedtime()
            }
        )
        
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time", selection: bindingWake, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: bindingSleepAmount, in: 4...12, step: 0.25)
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Picker("", selection: bindingCoffeeAmount) {
                            ForEach(1...6, id: \.self) {
                                Text("\($0)")
                            }
                            
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(alertTitle)
                            .font(.headline)
                        
                        Text(alertMessage)
                            .font(.body)
                            .pickerStyle(.segmented)
                    }
                }
            }
            .navigationTitle("BetterRest")
        }
        .onAppear {
            calculateBedtime()
        }
    }
    
    private func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is:"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
