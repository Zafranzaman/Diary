//
//  ShowEventsViewController.swift
//  SimpleDiary
//
//  Created by Super on 05/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ShowEventsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowEventTableViewCell
        let event = Data[indexPath.row]
        
        cell.Title.text = event.Title
        cell.Event.text = event.Events
        cell.Date.text = event.Date
        cell.Time.text = event.Time
        cell.Venue.text = event.Venue
        cell.Description.text = event.Description
        cell.Repeat.tag = indexPath.row
        cell.Repeat.addTarget(self, action: #selector(repeats), for: .touchUpInside)
        return cell
    }
    @objc func repeats(sender:UIButton){
        let data = IndexPath(row: sender.tag, section: 0)
        let index = data.row
        var d = Data[index]
        print(" Event Id is: \(d.did)")
        let query = "update AddEvent set Repeat = '1' where did = '\(d.did)'"
        if db.CreateInsertUpdateDelete(query: query){
            let alert = UIAlertController(title: "Alert!!!", message: "Event Repeated! ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var currentdate:UITextField!
    @IBOutlet weak var Datepicker: UIDatePicker!
    
    
    @IBAction func searchevent(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Datepicker.date)
        Data = db.getAllInfoSearch(search:dateString)
        tableview.reloadData()
        
    }
    
    
    
    
    var Data = [DairyInfomation]()
    var db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        Data = db.getAllInfo()
        print(Data)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        currentdate.text = currentDate
        currentdate.tintColor = .red
    }
    @IBAction func allevent(_ sender: Any) {
        Data = db.getAllInfo()
        tableview.reloadData()
        
    }
    @IBAction func birthdayevent(_ sender: Any) {
        Data = db.getAllInfoForBirthday()
        tableview.reloadData()
        
    }
    @IBAction func Holidayevent(_ sender: Any) {
        Data = db.getAllInfoForPublic()
        tableview.reloadData()
        
    }
    @IBAction func Repeatevent(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Get the selected date from the date picker
        let selectedDate = Datepicker.date
        
        // Subtract 1 year from the selected date
        if let modifiedDate = Calendar.current.date(byAdding: .year, value: -1, to: selectedDate) {
            let dateString = dateFormatter.string(from: modifiedDate)
            
            // Call your function with the modified date string
            Data = db.getAllInforRepeated(search: dateString)
            tableview.reloadData()
        }
    }

    
    @IBAction func todayevent(_ sender: Any) {
        Data = db.getAllInfoForToday()
        tableview.reloadData()
        
    }
    @IBAction func btnback(_ sender: Any) {
        let controller = try! self.storyboard?.instantiateViewController(withIdentifier: "AddEventViewController")
        //        controller?.modalPresentationStyle = .fullScreen
        //        present(controller!, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller!, animated: true)
        return
    }
    
}
