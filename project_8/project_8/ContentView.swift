//
//  ContentView.swift
//  project_8
//
//  Created by user on 29.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    private let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink {
//                    Text("Detail View \(row)")
//                } label: {
//                    Text("Hello, world \(row)!").padding()
//                }
//            }
//                .navigationTitle("SwiftUI")
//        }
        
//        VStack {
//            ScrollView(.vertical) {
//                LazyVStack(spacing: 10) {
//                    ForEach(0..<100) {
//                        Text("Item \($0)").font(.title)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//            ScrollView(.horizontal) {
//                LazyHStack(spacing: 10) {
//                    ForEach(0..<100) {
//                        Text("Item \($0)").font(.title)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }
        
//        GeometryReader { geo in
//            Image("Example")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.8)
//                .frame(width: geo.size.width, height: geo.size.height)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
