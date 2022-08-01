//
//  ContentView.swift
//  project_7
//
//  Created by user on 01.08.2022.
//

import SwiftUI

struct User: Codable {
    var firstName: String = ""
    var secondName: String = ""
}

struct ContentView: View {
    
    @State private var user = User()
    
    private let defaults = UserDefaults.standard
    private let userDefaultsKey = "UserData"
    
    var body: some View {
        VStack{
            Spacer()
            Text("User name: \(user.firstName) \(user.secondName)")
            TextField("first name", text:  $user.firstName)
            TextField("second name", text:  $user.secondName)
            Spacer()
            Button("Save user") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user) {
                    defaults.set(data, forKey: userDefaultsKey)
                }
                
            }
        }
        .padding()
        .onAppear {
            let decoder = JSONDecoder()
            if let userFromDefaults = defaults.object(forKey: userDefaultsKey) as? Data {
                if let user = try? decoder.decode(User.self, from: userFromDefaults) {
                    self.user = user
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
