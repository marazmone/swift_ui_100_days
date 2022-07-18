//
//  ContentView.swift
//  project_5
//
//  Created by Serhii Hulenko on 18.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    private let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List {
            Text("Static Row")

                ForEach(people, id: \.self) {
                    Text($0)
                }

                Text("Static Row")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
