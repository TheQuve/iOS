//
//  AnswerTableListCell.swift
//  Quve
//
//  Created by ParkSungJoon on 30/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class AnswerTableListCell: UITableViewCell {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
