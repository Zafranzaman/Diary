//
//  ShowDetailsViewController.swift
//  SimpleDiary
//
//  Created by Super on 27/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    var Data = [DairyInfomation]()
    var chaintitle = ""
    var db = dbmanager()
    @IBOutlet weak var tableview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(chaintitle)
        Data = db.getAllInfo(ChainTitle:chaintitle)
        print(Data)
        
    }
    
    
}
extension ShowDetailsViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventDetailsTableViewCell
        let event = Data[indexPath.row]
        
        cell.Title.text = event.Title
        cell.Event.text = event.Events
        cell.Date.text = event.Date
        cell.Time.text = event.Time
        cell.Venue.text = event.Venue
        cell.Description.text = event.Description
        //        cell.Repeat.tag = indexPath.row
        //        cell.Repeat.addTarget(self, action: #selector(repeats), for: .touchUpInside)
        return cell
    }
    
}
