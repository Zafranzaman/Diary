//
//  testViewController.swift
//  SimpleDiary
//
//  Created by Super on 02/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var Datepicker: UIDatePicker!
    
    
let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = "CREATE TABLE IF NOT EXISTS Test (tid INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Date TEXT)"
        db.CreateInsertUpdateDelete(query: query)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Datepicker.date)
        
        let query = "INSERT INTO Test (Name, Date) VALUES ('\(txtName.text ?? "empty")', '\(dateString)')"
        
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
