//
//  AddEventViewController.swift
//  SimpleDiary
//
//  Created by Super on 05/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit
import DropDown
class AddEventViewController: UIViewController {
var db = dbmanager()
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtVenue: UITextField!
    @IBOutlet weak var txtEvents: UITextField!
    @IBOutlet weak var Datepicker: UIDatePicker!
    @IBOutlet weak var TimePicker: UIDatePicker!
    @IBOutlet weak var txtDiscription: UITextField!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownView: UIView!
     var Events = ""
    override func viewDidLoad() {
       
        super.viewDidLoad()
        dropdowndata()
        let query = "CREATE TABLE IF NOT EXISTS AddEvent (did INTEGER PRIMARY KEY AUTOINCREMENT,Title TEXT,Venue TEXT,Event TEXT,Date TEXT,Time TEXT,Description TEXT,Repeat TEXT)"
        db.CreateInsertUpdateDelete(query: query)

    }
    func dropdowndata() {
        dropDown.dataSource  = array
        dropDown.reloadAllComponents()
        dropDown.anchorView = dropDownView
        //        dropDown.dataSource = ["Rwp","ISB","Karachi"]
        // Top of drop down will be below the anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            
            self.Events = item
            self.dropDownLabel.text = item
            print(item)
        }
        dropDown.direction = .any
        dropDownView.layer.borderWidth = 2
        dropDownView.layer.borderColor = UIColor.gray.cgColor
        dropDownView.layer.cornerRadius = 5

    }
   
    let dropDown = DropDown()
    var array = ["Birthday","Anniversary","Public Holidays","Others"]
    
    
        @IBAction func dropDownClick(_ sender: Any) {
        dropDown.show()
    }
    
    
    
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let title = txtTitle.text,
            let venue = txtVenue.text,
          //  let event = txtEvents.text,
            let description = txtDiscription.text else {
                return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Datepicker.date)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: TimePicker.date)

        let query = "INSERT INTO AddEvent (Title, Venue, Event, Date, Time, Description,Repeat) VALUES ('\(title)', '\(venue)', '\(Events)', '\(dateString)', '\(timeString)', '\(description)','0')"
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

//    @IBAction func chkboxClick(_ sender: UIButton) {
//        if sender.tag == 1 {
//            if sun.isSelected {
//                sun.isSelected = false
//                sunday = ""
//            }else{
//                sun.isSelected = true
//                sunday = "Sunday"
//            }
//        }
//    }
    }

