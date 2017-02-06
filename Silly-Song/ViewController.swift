//
//  ViewController.swift
//  Silly-Song
//
//  Created by Jatin Patel on 2017-02-05.
//  Copyright © 2017 Jatin Patel. All rights reserved.
//

import UIKit

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        displayLyrics(textField)    // calling displayLyrics here so action happen
        return true
    }
}

class ViewController: UIViewController {

    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     function to return short-hand version of given name
     @param name Name that need to be short-handed
     @return short-handed version of name using given logic
     */
    
    func shortNameFromName(name: String) -> String {

        var newName = name.lowercased()     //lowercase name fro furthure complication
        newName = newName.folding(options: .diacriticInsensitive, locale: .current) //checking those special chars
        
        let vowelList = CharacterSet.init(charactersIn:"aeiou")     // creating char-SET for vowels
        
        if let firstVowelRange = newName.rangeOfCharacter(from: vowelList, options: .caseInsensitive) {
            return newName.substring(from: firstVowelRange.lowerBound)
        }
        
        return newName
    }
    
    // join an array of strings into a single template string:
    var bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    /**
     function to compose lyrics using given name
     @param lyricsTemplate  lyrics template
     @param fullName    name used to generate silly Song
     @return newly generated silly song
     */
    func lyricsForName(lyricsTemplate:String, fullName:String)->String{
        let shortName = shortNameFromName(name: fullName)
        
        let newLyric = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return newLyric
    }
    
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""     // on click erase text filed
        lyricsView.text = ""    // on click erase text view
    }


    @IBAction func displayLyrics(_ sender: Any) {
        let name = nameField.text   // getting name to be use from inputbox
        let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name!) //magic happening here
        lyricsView.text = lyrics    //assigning new lyric to text view
    }
}

