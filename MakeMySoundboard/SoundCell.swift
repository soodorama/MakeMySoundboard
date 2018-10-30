//
//  SoundCell.swift
//  MakeMySoundboard
//
//  Created by Neil Sood on 9/27/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import AVFoundation

class SoundCell: UITableViewCell {
    
    @IBOutlet weak var firstButton: UIButton!
    //    @IBOutlet weak var secondButton: UIButton!
    //    @IBOutlet weak var thirdButton: UIButton!
    
    var player: AVAudioPlayer?
    var isPlaying: Bool = true
    
    @IBAction func firstBtnPressed(_ sender: UIButton) {
        print("first button pressed")
        let name = sender.titleLabel?.text
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        do {
            //            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            // The following line is required for the player to work on iOS 11. Change the file type accordingly
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            if isPlaying == true {
                player.play()
            }
            else {
                player.stop()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    //
    //    @IBAction func secondBtnPressed(_ sender: UIButton) {
    //        print("second button pressed")
    //    }
    //
    //    @IBAction func thirdBtnPressed(_ sender: UIButton) {
    //        print("third button pressed")
    //    }
    
}

