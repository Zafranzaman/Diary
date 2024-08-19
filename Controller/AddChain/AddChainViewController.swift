//
//  AddChainViewController.swift
//  SimpleDiary
//
//  Created by Super on 22/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class AddChainViewController: UIViewController {
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var ChainTitle:UITextField!
    var Data = [DairyInfomation]()
    var db = dbmanager()
    var selectedRows = Set<Int>()
    var selectedDidValues = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        Data = db.getAllInfo()
        
    }
    
    @IBAction func SaveChainData(_ sender: Any) {
        tablecreate()
        print(selectedDidValues)
        guard let chainTitlev = ChainTitle.text
            else {
                return
        }
        var savedata = [AddChainEvent]()
        for data in selectedDidValues {
            var a = AddChainEvent(did:data,ChainTitle:chainTitlev)
            savedata.append(a)
        }
        print(savedata)
        
        if savedata.count != 0 {
        for a in savedata {
            
            let query = "INSERT INTO AddChainEvent (ChainTitle, did) VALUES ('\(a.ChainTitle)', '\(a.did)')"
            db.CreateInsertUpdateDelete(query: query)
            
        }
        
        let alert = UIAlertController(title: "Alert!!!", message: "Data Inserted!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Alert!!!", message: "No Event is Selected!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func tablecreate() {
        let query = "CREATE TABLE IF NOT EXISTS AddChainEvent (ChainEventid INTEGER PRIMARY KEY AUTOINCREMENT, ChainTitle TEXT, did INTEGER, FOREIGN KEY (did) REFERENCES AddEvent(did))"

        db.CreateInsertUpdateDelete(query: query)
    }
    
}
extension AddChainViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 197
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllEventTableViewCell
        let event = Data[indexPath.row]
        
        cell.Title.text = event.Title
        cell.Event.text = event.Events
        cell.Date.text = event.Date
        cell.Venue.text = event.Venue
        //cell.CheckBox.tag = indexPath.row
        // Set the checkbox tag
        cell.CheckBox.tag = indexPath.row
        
        // Set the checkbox state based on selectedRows
        cell.CheckBox.isSelected = selectedRows.contains(indexPath.row)
        
        // Configure the action to toggle the checkbox state
        cell.CheckBox.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkboxTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        
        // Toggle the selected state
        if selectedRows.contains(rowIndex) {
            selectedRows.remove(rowIndex)
            if let indexToRemove = selectedDidValues.firstIndex(of: Data[rowIndex].did) {
                selectedDidValues.remove(at: indexToRemove)
            }
        } else {
            selectedRows.insert(rowIndex)
            selectedDidValues.append(Data[rowIndex].did)
        }
        
        tableview.reloadData()
    }
    
}
