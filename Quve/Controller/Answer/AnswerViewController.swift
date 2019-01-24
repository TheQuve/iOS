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
    @IBAction func filterBarButton(_ sender: UIBarButtonItem) {
        let filterVC = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.present(filterVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "AnswerTableListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AnswerTableListCell")
        setNavigationUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setNavigationUI() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AnswerDetailViewController") as! AnswerDetailViewController
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
