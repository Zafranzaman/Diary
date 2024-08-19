////
////  TestDisplayViewController.swift
////  SimpleDiary
////
////  Created by Super on 07/09/2023.
////  Copyright © 2023 Super. All rights reserved.
////
//
//import UIKit
//
//class TestDisplayViewController: UIViewController {
//
//    @IBOutlet weak var tableView:UITableView!
//    var testarray = [gettest1]()
//    let db = dbmanager()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        testarray = db.getAllInfo()
//    }
//    
//    
//}
//extension testdisplaybyshafayViewController :UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return testarray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! testdisplaybyshafayTableViewCell
//        let event = testarray[indexPath.row]
//        
//        cell.Name.text = event.Name
//        cell.Time.text = event.Time
//        return cell
//    }
//    
//}
