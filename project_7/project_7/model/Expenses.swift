//
//  Expenses.swift
//  project_7
//
//  Created by user on 02.08.2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: ITEMS_KEY)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: ITEMS_KEY) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
