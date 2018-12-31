//
//  AnswerTableListCell.swift
//  Quve
//
//  Created by ParkSungJoon on 30/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class AnswerTableListCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let screenSize = UIScreen.main.bounds.size
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: screenSize.width, bottom: 0, right: 0)
        setRoundView()
        setShadowView()
        setUserProfileImageView()
    }
    
    private func setUserProfileImageView() {
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
    }

    private func setShadowView() {
        shadowView.layer.applySketchShadow(
            color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            alpha: 0.05,
            x: 0,
            y: 2,
            blur: 6,
            spread: 0
        )
    }
    
    private func setRoundView() {
        roundView.layer.masksToBounds = true
        roundView.layer.cornerRadius = 13
        roundView.layer.borderWidth = 1.0
        roundView.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    }
    
}
