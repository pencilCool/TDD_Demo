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
        var numberOfVowels = 0
        for character in string.characters {
            if vowels.contains(character) {
                numberOfVowels = numberOfVowels + 1;
            } }
        return numberOfVowels
    }


}

