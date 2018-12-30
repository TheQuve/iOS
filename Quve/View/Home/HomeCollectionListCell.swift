//
//  HomeCollectionListCell.swift
//  Quve
//
//  Created by ParkSungJoon on 17/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class HomeCollectionListCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var answerNameLabel: UILabel!
    @IBOutlet weak var answerClassLabel: UILabel!
    @IBOutlet weak var answerCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
