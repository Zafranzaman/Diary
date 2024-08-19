//
//  RepeatEventViewController.swift
//  SimpleDiary
//
//  Created by Super on 27/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class RepeatEventViewController: UIViewController {

    var Data = [DairyInfomation]()
    var db = dbmanager()
    @IBOutlet weak var tableview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Data = db.getAllInfoRepeat()
        print(Data)
        
    }
    
    func incrementYearInDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            if let incrementedDate = calendar.date(byAdding: .year, value: 1, to: date) {
                return dateFormatter.string(from: incrementedDate)
            }
        }
        
        return nil
    }
    
   

    
}
extension RepeatEventViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepeatEventTableViewCell
        let event = Data[indexPath.row]
        
        cell.Title.text = event.Title
        cell.Event.text = event.Events
        cell.Date.text = event.Date
        // Assuming 'event' is your DairyInfomation object
        if let incrementedDate = incrementYearInDate(dateString: event.Date) {
            // Update the cell's labels with the modified date
            cell.Date.text = incrementedDate
        } else {
            // Handle error or invalid date format
            cell.Date.text = "Invalid Date"
        }
        cell.Venue.text = event.Venue
        cell.Description.text = event.Description
        return cell
    }
    
}
