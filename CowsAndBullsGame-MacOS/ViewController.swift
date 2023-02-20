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
        
    }
    
    private func result(for guess: String) -> String {
        "Result"
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
