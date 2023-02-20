//
//  ViewController.swift
//  CowsAndBullsGame-MacOS
//
//  Created by Sadık Çoban on 20.02.2023.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var guess: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @IBAction func submitGuess(_ sender: Any) {
        
    }

}

