//
//  ContentView.swift
//  project_3
//
//  Created by Serhii Hulenko on 08.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    var motto3: some View {
        Text("Draco dormiens")
    }
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    
    var body: some View {
        VStack {
            Text("Hello World")
                .titleStyle()
            
            CapsuleText(text: "First")
            
            Color.blue
                .frame(width: 300, height: 50)
                .watermarked(with: "Hacking with Swift")

        
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
            motto3
            HStack {
                spells
            }
            spells
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                    .blur(radius: 3)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
