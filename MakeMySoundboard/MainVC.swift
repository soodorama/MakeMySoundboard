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
    
    @IBOutlet weak var tableView: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tableData: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchSounds()
        
    }
    
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddDeleteSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let dest = nav.topViewController as! AddDeleteVC
        dest.delegate = self
        
        if let indexPath = sender as? IndexPath {
            dest.indexPath = indexPath
            dest.titleField.text = tableData[indexPath.row].filename!
            dest.filename = tableData[indexPath.row].filename!
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
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundCell
        let sound = tableData[indexPath.row]
        //        cell.souLabel.text = sound.text
        //        cell.indexPath = indexPath
        //        cell.delegate = self
        //        return cell
        cell.firstButton.setTitle(sound.filename, for: .normal)
        
        return cell
    }
}

extension MainVC: AddDeleteVCDelegate {
    func cancelPressed() {
        print("Cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func savePressed(filename: String, indexPath: IndexPath?) {
        print("Saved",filename)
        
        dismiss(animated: true, completion: nil)
    }
}


