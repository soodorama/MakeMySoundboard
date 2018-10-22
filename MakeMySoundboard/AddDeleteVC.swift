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
    func savePressed(displayname: String, indexPath: IndexPath?)
}

class AddDeleteVC: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    
    let playColor = UIColor(red: 63.0/255, green: 140.0/255, blue: 39.0/255, alpha: 1)
    
    var delegate: AddDeleteVCDelegate?
    var indexPath: IndexPath?
    var displayname = ""
    var filename = ""
    var hasSound = false
    var isDeleted = false
    
    var recorder: AVAudioRecorder?
    var session = AVAudioSession.sharedInstance()
    var player: AVAudioPlayer?
    
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 44100,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let indexPath = indexPath {
            playButton.backgroundColor = playColor
            playButton.setTitle("Play", for: .normal)
//            titleField.text = displayname
            recordButton.setTitle("Delete", for: .normal)
//            filename =
            hasSound = true
        }
        else {
            playButton.backgroundColor = .gray
            playButton.setTitle("", for: .normal)
        }
        
        
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
        titleField.text = displayname
        filename = displayToFilename(displayname)
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        print("Play")
        // should be gray if no audio, else clover green
        
    }
    
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        if recordButton.titleLabel?.text == "Record" {
            print("Record")
            recordButton.setTitle("Save", for: .normal)
            hasSound = true
            record()
            
        }
        else if recordButton.titleLabel?.text == "Save" {
            print("Save")
            recordButton.setTitle("Record", for: .normal)
            isDeleted = false
            hasSound = true
            playButton.setTitle("Play", for: .normal)
            playButton.backgroundColor = playColor
            
        }
        else if recordButton.titleLabel?.text == "Delete" {
            print("Delete")
            isDeleted = true
            hasSound = false
        }
        
        // change to delete if it there is already audio
        
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelPressed()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if (titleField.text != "") {
            let displayname = titleField.text
            delegate?.savePressed(displayname: displayname!, indexPath: indexPath)
        }
    }
    
    func finishRecording(success: Bool) {
        recorder?.stop()
        recorder = nil
        
        if success {
            //            print("Finished Recording")
        } else {
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your audio; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
//    @IBAction func offPressed(_ sender: UIButton) {
//        if isOn {
//            //            print("Off")
//            isOn = false
//            isBeating = false
//
//            onButton.backgroundColor = .orange
//            offButton.backgroundColor = .gray
//
//            recordTimer.invalidate()
//            playTimer.invalidate()
//
//            finishRecording(success: true)
//            globalPlayer?.stop()
//            beatPlayer?.stop()
//        }
//    }
    
    func loadRecordingUI() {
        print("LETS RECORD")
    }
    
    func loadFailUI() {
        print("FAIL")
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getAudioURL(urlStr: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(urlStr+".m4a")
    }
    
    func displayToFilename(_ displayname: String) -> String {
        var filename = ""
        for i in displayname {
            if i == " " {
                filename += "_"
            }
            else {
                filename += String(i)
            }
        }
        return filename
    }
    
}

extension AddDeleteVC: AVAudioRecorderDelegate {
    func record() {
        if let rec = recorder {
            recorder!.stop()
        }
        
        let audioURL = AddDeleteVC.getAudioURL(urlStr: filename)
        
        do {
            self.recorder = try AVAudioRecorder(url: audioURL, settings: settings)
            self.recorder?.delegate = self
            self.recorder?.prepareToRecord()
            self.recorder?.record()
        } catch {
            self.finishRecording(success: false)
        }
    }
    
    func play() {
        
        print("Play")
        //
        ////        let str = audioQueue.dequeue()
        ////        let url = AddDeleteVC.getAudioURL(urlStr: str!)
        //
        //        do {
        //            player = try AVAudioPlayer(contentsOf: url)
        ////            player.play()
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
}

