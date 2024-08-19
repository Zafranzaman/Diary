//
//  ExampleViewController.swift
//  SimpleDiary
//
//  Created by Super on 07/09/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    
    
    var testarray = [Addform1]()
    let db = dbmanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testarray = db.getAddAllInfo1()
    }
    
    
}
extension ExampleViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExampleTableViewCell
        let event = testarray[indexPath.row]
        
        cell.Name.text = event.Name
        cell.Date.text = event.Time
        cell.Event.text = event.description
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let event = testarray[indexPath.row]
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
//        vc.name = event.Name
//        vc.ds = event.description
//        vc.date = event.Time
//        vc.tid = event.tid
//       // self.navigationController?.pushViewController(vc, animated: true)
//
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true,completion: nil)
//
//
//
//
//    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let event = testarray[indexPath.row]
//
//    let query = "DELETE from event where tid = \(event.tid)"
//     db.CreateInsertUpdateDelete(query: query)
    
    
//    }
    
}
