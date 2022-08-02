//
//  ExpenseItem.swift
//  project_7
//
//  Created by user on 02.08.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id: String = UUID.init().uuidString
    let name: String
    let type: String
    let amount: Double
}
