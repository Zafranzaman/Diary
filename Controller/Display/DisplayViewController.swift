//
//  DisplayViewController.swift
//  SimpleDiary
//
//  Created by Super on 07/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    
    
    var testarray = [Addform1]()
    let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testarray = db.getAddAllInfo1()
    }
    
    
}
extension DisplayViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DisplayTableViewCell
        let event = testarray[indexPath.row]
        
        cell.Name.text = event.Name
        cell.Date.text = event.Name
        cell.Event.text = event.Name
        return cell
    }
    
}
