//
//  ExampleSaveViewController.swift
//  SimpleDiary
//
//  Created by Super on 07/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ExampleSaveViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var TimePicker: UIDatePicker!
    @IBOutlet weak var dscription: UITextField!
    
    
    let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = "CREATE TABLE IF NOT EXISTS Example (tid INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Time TEXT, description TEXT)"
        db.CreateInsertUpdateDelete(query: query)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: TimePicker.date)
        
        
        let query = "INSERT INTO Example (Name, Time, description) VALUES ('\(txtName.text ?? "empty")', '\(timeString)','\(txtName.text ?? "empty")')" 
        if db.CreateInsertUpdateDelete(query: query){
            let alert = UIAlertController(title: "Alert!!!", message: "Data Inserted!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert!!!", message: "unable to Save data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
