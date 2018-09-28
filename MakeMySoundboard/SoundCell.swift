//
//  SoundCell.swift
//  MakeMySoundboard
//
//  Created by Neil Sood on 9/27/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

class SoundCell: UITableViewCell {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBAction func firstBtnPressed(_ sender: UIButton) {
        print("First Button Pressed")
    }
    
    @IBAction func secondBtnPressed(_ sender: UIButton) {
        print("Second Button Pressed")
    }

    @IBAction func thirdBtnPressed(_ sender: UIButton) {
        print("Third Button Pressed")
    }
}
