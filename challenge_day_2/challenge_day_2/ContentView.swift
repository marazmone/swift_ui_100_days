//
//  ContentView.swift
//  challenge_day_2
//
//  Created by Serhii Hulenko on 11.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Result message
    private let WIN = "You are win! +1"
    private let LOSE = "You are lose! -1"
    private let DEAD_HEAT = "Dead heat!"
    
    // MARK: Velues
    private let valuesArray = ["Rock", "Paper", "Scissors"]
    
    // MARK: States
    @State private var playerChoice = ""
    @State private var score = 0
    @State private var showAlert = false
    @State private var resultTitle = ""
    @State private var resultMessage = ""
    
    // MARK: Body
    var body: some View {
        let binding = Binding(
            get: { showAlert },
            set: { showAlert = $0 }
        )
        VStack {
            Spacer()
            Text("Score: \(score)")
                .font(.title)
            Spacer()
            HStack {
                ForEach(valuesArray, id: \.self) { value in
                    Button {
                        checkResult(choice: value)
                        showAlert = true
                    } label: {
                        Text(value)
                            .modifier(ButtonModifier(width: 70))
                    }
                }
            }
            .alert(resultTitle, isPresented: binding){
                Button("OK", role: .none) {
                    showAlert = false
                }
            } message: {
                Text(resultMessage)
            }
            Spacer()
        }
    }
    
    // MARK: Check result
    private func checkResult(choice playerChoice: String) {
        self.playerChoice = playerChoice
        let computer = valuesArray[Int.random(in: 0...2)]
        resultMessage = "Your choice: \(playerChoice)\nComputer choices: \(computer)"
        if playerChoice == computer {
            resultTitle = DEAD_HEAT
        } else {
            if (playerChoice == "Rock" && computer == "Scissors") || (playerChoice == "Paper" && computer == "Rock") ||  (playerChoice == "Scissors" && computer == "Paper"){
                score += 1
                resultTitle = WIN
            } else {
                score -= 1
                resultTitle = LOSE
            }
        }
    }
}

// MARK: Button Modifier
struct ButtonModifier: ViewModifier {
    
    var width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
    }
}


// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
