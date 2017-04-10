//
//  ViewController.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func numberOfVowelsInString(string: String) -> Int {
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I",
                                   "O", "U"]
        return string.characters.reduce(0) { $0 + (vowels.contains($1) ? 1
            : 0)
        }
        
    }
    
    func makeHeadline(string: String) -> String{
        let words = string.components(separatedBy:" ")
        let headline = words.map { (word: String) -> String in
            var word = word
            let firstCharacter = word.remove(at: word.startIndex)
            return "\(String(firstCharacter).uppercased())\(word)"
            }.joined(separator:" ")

        return headline
    }

}

