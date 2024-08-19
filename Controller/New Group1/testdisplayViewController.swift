

//
//  testdisplayViewController.swift
//  SimpleDiary
//
//  Created by Super on 02/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class testdisplayViewController: UIViewController {
@IBOutlet weak var tableView:UITableView!
    
    
    var testarray = [gettest]()
    let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()

        testarray = db.getAllInfo()
    }
    

}
extension testdisplayViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! testdisplayTableViewCell
        let event = testarray[indexPath.row]
        
        cell.Name.text = event.Name
        cell.Date.text = event.Date
        return cell
    }
    
}
