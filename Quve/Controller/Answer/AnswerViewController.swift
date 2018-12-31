//
//  AnswerViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 21/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "AnswerTableListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AnswerTableListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension AnswerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTagTableCell", for: indexPath) as! HeaderTagTableCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableListCell", for: indexPath) as! AnswerTableListCell
            return cell
        }
    }
    
    
}
