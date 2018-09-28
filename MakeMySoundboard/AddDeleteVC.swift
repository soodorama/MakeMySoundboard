//
//  AddDeleteVC.swift
//  MakeMySoundboard
//
//  Created by Neil Sood on 9/27/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

protocol AddDeleteVCDelegate: class {
    func cancelPressed()
    func savePressed(filename: String, indexPath: IndexPath?)
}

class AddDeleteVC: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    
    var delegate: AddDeleteVCDelegate?
    var indexPath: IndexPath?
    var filename = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleField.text = filename
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        print("Play")
        // should be gray if no audio, else clover green
    }
    
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        print("Record")
        // change to delete if it there is already audio
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        print("whaa")
        delegate?.cancelPressed()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let filename = titleField.text
        delegate?.savePressed(filename: filename!, indexPath: indexPath)
    }
    
}
