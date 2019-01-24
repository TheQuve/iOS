//
//  AnswerDetailViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 25/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import UIKit

class AnswerDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userImageview: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userIntroduceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var answerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        userImageview.layer.masksToBounds = true
        userImageview.layer.cornerRadius = userImageview.frame.width / 2
        
        shadowView.layer.applySketchShadow(
            color: #colorLiteral(red: 0.6470588235, green: 0.662745098, blue: 0.6745098039, alpha: 1),
            alpha: 0.24,
            x: 0,
            y: 5,
            blur: 12,
            spread: 0
        )
        roundView.layer.masksToBounds = true
        roundView.layer.cornerRadius = 15
        roundView.layer.borderWidth = 1.0
        roundView.layer.borderColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 0.67)
        answerButton.layer.masksToBounds = true
        answerButton.layer.cornerRadius = 30
    }
    
}
