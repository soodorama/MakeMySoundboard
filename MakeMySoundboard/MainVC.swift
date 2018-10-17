//
//  MainVC.swift
//  MakeMySoundboard
//
//  Created by Neil Sood on 9/27/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    var cellPos = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tableData: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSounds()
        tableView.reloadData()
    }
    
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddDeleteSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let dest = nav.topViewController as! AddDeleteVC
        dest.delegate = self
        
        let send = sender as! UIButton
        if send.tag != 0 {
            
        }
        if let indexPath = sender as? IndexPath {
            dest.indexPath = indexPath
            dest.titleField.text = tableData[indexPath.row].displayname!
            dest.displayname = tableData[indexPath.row].displayname!
        }
    }
    
    func fetchSounds() {
        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
        
        do {
            tableData = try context.fetch(request)
        } catch {
            print("\(error)")
        }
        
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

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundCell
        if tableData.count > 3 {
            let sound1 = tableData[indexPath.row].first
            let sound2 = tableData[indexPath.row].second
            let sound3 = tableData[indexPath.row].third
            cell.firstButton.setTitle(sound1.displayname, for: .normal)
            cell.secondButton.setTitle(sound2.displayname, for: .normal)
            cell.thirdButton.setTitle(sound3.displayname, for: .normal)
        }
        else if tableData.count > 2 {
            
        }
        else if tableData.count > 1 {
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundCell
        let sound = tableData[indexPath.row]
        cell.firstButton.setTitle(sound.displayname, for: .normal)
        
        return cell
    }
}

extension MainVC: AddDeleteVCDelegate {
    func cancelPressed() {
        print("Cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func savePressed(displayname: String, indexPath: IndexPath?) {
        if let indexPath = indexPath {
            print("update")
            let sound = tableData[indexPath.row]
            sound.displayname = displayname
            sound.filename = displayToFilename(displayname)
        }
        else {
            let sound = Sound(context:context)
            sound.displayname = displayname
            sound.filename = displayToFilename(displayname)
            tableData.append(sound)
        }
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        
        print("Saved",displayname)
        dismiss(animated: true, completion: nil)
    }
}


