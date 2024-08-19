//
//  Test1ViewController.swift
//  SimpleDiary
//
//  Created by Super on 02/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class Test1ViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var TimePicker: UIDatePicker!
    
    
    let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = "CREATE TABLE IF NOT EXISTS Test1 (tid INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Time TEXT)"
        db.CreateInsertUpdateDelete(query: query)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: TimePicker.date)

        
        let query = "INSERT INTO Test1 (Name, Time) VALUES ('\(txtName.text ?? "empty")', '\(timeString)')"
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
