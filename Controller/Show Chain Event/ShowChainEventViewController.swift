//
//  ShowChainEventViewController.swift
//  SimpleDiary
//
//  Created by Super on 27/08/2023.
//  Copyright © 2023 Super. All rights reserved.
//

import UIKit

class ShowChainEventViewController: UIViewController {
    var allchaintitle = [ChainTitle]()
    var db = dbmanager()
    @IBOutlet weak var tableview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allchaintitle = db.getAllChainInfo()
        print(allchaintitle)
    }
    
}
extension ShowChainEventViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allchaintitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowChainEventTableViewCell
        let event = allchaintitle[indexPath.row]
        
        cell.Title.text = event.ChainTitle
        
        
        cell.Nextbutton.tag = indexPath.row
        
        
        // Configure the action to toggle the checkbox state
        cell.Nextbutton.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkboxTapped(_ sender: UIButton) {
        let data = IndexPath(row: sender.tag, section: 0)
        let index = data.row
        let title = allchaintitle[index].ChainTitle
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailsViewController") as! ShowDetailsViewController
        secondViewController.chaintitle = title
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
    
}
