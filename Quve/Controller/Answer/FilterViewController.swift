//
//  FilterViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 31/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import RxSwift

class FilterViewController: UIViewController {

    @IBOutlet weak var lastestButton: UIButton!
    @IBOutlet weak var closestButton: UIButton!
    
    @IBOutlet weak var educationButton: UIButton!
    @IBOutlet weak var societyButton: UIButton!
    @IBOutlet weak var computerButton: UIButton!
    @IBOutlet weak var tripButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var economyButton: UIButton!
    @IBOutlet weak var lifestyleButton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var artButton: UIButton!
    @IBOutlet weak var placeButton: UIButton!
    
    @IBOutlet var uiButtons: [UIButton]!
    @IBOutlet var sortSectionButtons: [UIButton]!
    @IBOutlet var topicSectionButtons: [UIButton]!
    
    @IBAction func backBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIButtons()
    }
    
    private func setUIButtons() {
        for button in uiButtons {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        }
    }
    
    private func isSelected(){
        
    }
}
