//
//  AddDeleteVC.swift
//  MakeMySoundboard
//
//  Created by Neil Sood on 9/27/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import AVFoundation

protocol AddDeleteVCDelegate: class {
    func cancelPressed()
    func savePressed(filename: String, indexPath: IndexPath?)
}

class AddDeleteVC: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    
    let playColor = UIColor(red: 39, green: 145, blue: 0, alpha: 1)
    
    var delegate: AddDeleteVCDelegate?
    var indexPath: IndexPath?
    var filename = ""
    
//    var player: AVAudioPlayer?
    var recorder: AVAudioRecorder?
    var session = AVAudioSession.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let indexPath = indexPath {
            playButton.backgroundColor = playColor
            playButton.setTitle("Play", for: .normal)
        }
        else {
            playButton.backgroundColor = .gray
            playButton.setTitle("", for: .normal)
        }
        
//        session =
        
        do {
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            
            session.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("allowed")
                    } else {
                        print("not allowed")
                    }
                }
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        titleField.text = filename
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        print("Play")
        // should be gray if no audio, else clover green
    
        //        print("Play")
        
//        let str = audioQueue.dequeue()
//        let url = MicVC.getAudioURL(urlStr: str!)
//
//        do {
//            globalPlayer = try AVAudioPlayer(contentsOf: url)
//            globalPlayer?.play()
//            //            print("Playing")
//            do {
//                try FileManager.default.removeItem(at: url)
//            } catch {
//                print("error deleting file")
//            }
//
//        } catch {
//            //            print("Error with player")
//            let ac = UIAlertController(title: "Playback failed", message: "There was a problem", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            //            present(ac, animated: true)
//        }
        
        
    }
    
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        print("Record")
        // change to delete if it there is already audio
        
        print("Record")
        
        if let rec = recorder {
            recorder!.stop()
        }

//        let audioURL = MainVC.getAudioURL(urlStr: urlStr)
        //        print(audioURL.absoluteString)
        
        do {
//            self.recorder = try AVAudioRecorder(url: audioURL, settings: settings)
            self.recorder?.delegate = self
            self.recorder?.prepareToRecord()
            self.recorder?.record()
        } catch {
            self.isOn = false
            self.finishRecording(success: false)
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelPressed()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let filename = titleField.text
        delegate?.savePressed(filename: filename!, indexPath: indexPath)
    }
    
//    func finishRecording(success: Bool) {
//        recorder?.stop()
//        recorder = nil
//        url_counter = 0
//
//        if success {
//            //            print("Finished Recording")
//        } else {
//            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your audio; please try again.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
//        }
//    }
//
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }
    
}
