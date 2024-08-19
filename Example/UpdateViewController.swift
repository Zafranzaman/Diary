//
//  UpdateViewController.swift
//  SimpleDiary
//
//  Created by Super on 07/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var TimePicker: UIDatePicker!
    @IBOutlet weak var dscription: UITextField!
    
    var name = ""
    var ds = ""
    var date = ""
    var tid = -1
    let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = name
        dscription.text = ds
        
       
       
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: TimePicker.date)
        
        
        let query = "UPDATE Example SET Name = '\(txtName.text ?? "")', Time = '\(timeString)', description = '\(dscription.text ?? "")' WHERE tid = \(tid)"


        if db.CreateInsertUpdateDelete(query: query){
            let alert = UIAlertController(title: "Alert!!!", message: "Data UPdated!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert!!!", message: "unable to Save data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
