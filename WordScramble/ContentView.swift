//
//  ContentView.swift
//  WordScramble
//
//  Created by Yunis Farah on 15/07/2020.
//  Copyright © 2020 LunarColony. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    //Properties for controlling error
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    func startGame() {
        //1. Find the url for start.txt in our app bundle
        if let startWordURl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //2. Load start.txt in to a string
            if let startWords = try? String(contentsOf: startWordURl) {
                //3. Split the string up into an array of string, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                //4. Pick on one random word or use "audience" as default
                rootWord = allWords.randomElement() ?? "audience"

                //5. If we are here everything has worked, so we can exit
                return
            }
        }

        self.usedWords.removeAll()
        fatalError("Could not load start.txt form bundle.")
    }
    
    
    func restartGame() {
        self.usedWords.removeAll()
    }

    func addnewWord() {
        // lowercase and trim the word, to make sure we dont add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        //exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }


        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them up")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That's are not a real word")
            return
        }

        usedWords.insert(answer, at: 0)
        newWord = ""
    }


    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
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

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }


    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addnewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                        .foregroundColor(Color.green)
                    Text($0)
                }
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)

                HStack {
                    Text("Words Guessed: \(usedWords.count)")
                        .foregroundColor(Color.black)
                    Spacer()
                    Button(action: {
                        self.startGame()
                        self.restartGame()
                    }) {
                        Text("Restart")
                            .foregroundColor(Color.red)
                    }
                
                }
                .padding()
            }
                .navigationBarTitle(rootWord)

                .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }


        }


    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}









/*
 if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            // we found the file in our bundle
 }
 
 if let fileContents = try? String(contentsOf: fileURL) {
            // we loaded the file into a string!
 }
 
 
 */
