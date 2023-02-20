//
//  ViewController.swift
//  CowsAndBullsGame-MacOS
//
//  Created by Sadık Çoban on 20.02.2023.
//

import Cocoa

final class ViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    

    @IBOutlet weak var guess: NSTextField!
    
    var answer = ""
    var guesses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func submitGuess(_ sender: Any) {
        // check for 4 unique characters
        let guessString = guess.stringValue
        guard Set(guessString).count == 4 else { return }
        
        // ensure there are no non-digit characters
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        // add the guess to the array and tableview
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        // did the player win?
        let resultString = result(for: guessString)
        if resultString.contains("4b") {
            let alert = NSAlert()
            alert.messageText = "You win"
            alert.informativeText = "Congratulations🎉 Click OK to play again."
            alert.runModal()
            
            startNewGame()
        }
    }
    
    private func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
    
    private func startNewGame() {
        guess?.stringValue = ""
        guesses.removeAll()
        answer = ""
        var numbers = Array(0...9)
        numbers.shuffle()
        for _ in 0 ..< 4 {
            answer.append(String(numbers.removeLast()))
        }
        tableView.reloadData()
    }
}



// MARK: - Extensions

extension ViewController: NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        guesses.count
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        if tableColumn?.title == "Guess" {
            // this is the Guess column, show a previous guess
            vw.textField?.stringValue = guesses[row]
        } else {
            // this is the Result column, call result
            vw.textField?.stringValue = result(for: guesses[row])
        }
        return vw
    }
    
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        false
    }
}
