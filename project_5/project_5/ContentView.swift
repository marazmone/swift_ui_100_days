//
//  ContentView.swift
//  project_5
//
//  Created by Serhii Hulenko on 18.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var levelScore = 0
    @State private var gameScore = 0
    @State private var gameLevels = [GameLevel]()
    
    @State private var allWords = [String]()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    HStack{
                        Text("Game score: \(gameScore)")
                        Spacer()
                        Text("Level score: \(levelScore)")
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                ForEach(gameLevels, id: \.uuid) { gameLevel in
                    Section {
                        ForEach(gameLevel.answers, id: \.self) { answer in
                            HStack {
                                Image(systemName: "\(answer.count).circle")
                                Text(answer)
                            }
                        }
                    } header: {
                        HStack{
                            Text("Level: \(gameLevel.word)")
                            Spacer()
                            Text("Score: \(gameLevel.score)")
                        }
                    }
                }
                
                
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button(action: {
                    updateGameLevel()
                    selectNewWord()
                }, label: { Text("New word") })
            }
            .onSubmit(addNewWord)
        }
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .onAppear(perform: startGame)
    }
    
    private func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isNotShort(word: answer) else {
            wordError(title: "Word is short", message: "You need to make the word longer by 2 chars!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        levelScore += answer.count
        gameScore += answer.count
        newWord = ""
    }
    
    private func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                selectNewWord()
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    private func selectNewWord() {
        rootWord = allWords.randomElement() ?? "silkworm"
    }
    
    private func isNotShort(word: String) -> Bool {
        return word.count > 2
    }
    
    private func updateGameLevel() {
        let gameLevel = GameLevel(answers: usedWords, word: rootWord, score: levelScore)
        gameLevels.insert(gameLevel, at: 0)
        levelScore = 0
        usedWords.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameLevel {
    let uuid = UUID.init()
    var answers = [String]()
    var word = ""
    var score = 0
}
