//
//  HeaderTagCollectionListCell.swift
//  Quve
//
//  Created by ParkSungJoon on 31/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class HeaderTagTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let screenSize = UIScreen.main.bounds.size
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: screenSize.width, bottom: 0, right: 0)
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 0)
    }
    
    private func setCollectionViewDataSourceDelegate<
        D: UICollectionViewDelegate & UICollectionViewDataSource
        > (
        dataSourceDelegate: D,
        forRow row: Int
        ) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
}

extension HeaderTagTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HeaderTagCollectionListCell",
            for: indexPath
            ) as! HeaderTagCollectionListCell
        cell.colorNumber = Int.random(in: 0...2)
        cell.tagLabel.text = "성공"
        return cell
    }
}

class HeaderTagCollectionListCell: UICollectionViewCell {
    
    @IBOutlet weak var gradationView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    private var mintColors: [CGColor] = [#colorLiteral(red: 0.3490196078, green: 1, blue: 0.9019607843, alpha: 1).cgColor,#colorLiteral(red: 0.2862745098, green: 0.8196078431, blue: 1, alpha: 1).cgColor]
    private var purpleColors: [CGColor] = [#colorLiteral(red: 0.3803921569, green: 0.662745098, blue: 0.9803921569, alpha: 1).cgColor,#colorLiteral(red: 0.6470588235, green: 0.1098039216, blue: 0.968627451, alpha: 1).cgColor]
    private var orangeColors: [CGColor] = [#colorLiteral(red: 0.9803921569, green: 0.8509803922, blue: 0.3803921569, alpha: 1).cgColor,#colorLiteral(red: 1, green: 0.4862745098, blue: 0.4274509804, alpha: 1).cgColor]
    
    var colorNumber: Int = 0{
        didSet{
            setContentViewShadowColor(colorNumber)
            let layer = setGradationColor(colorNumber)
            gradationView.layer.insertSublayer(layer, at: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setGradationView()
    }
    
    private func setGradationView() {
        gradationView.layer.masksToBounds = true
        gradationView.layer.cornerRadius = 16
    }
    
    func setContentViewShadowColor(_ num: Int){
        var color = UIColor()
        switch num {
        case 0: color = #colorLiteral(red: 0.1882352941, green: 0.9568627451, blue: 1, alpha: 0.68)
        case 1: color = #colorLiteral(red: 0.4470588235, green: 0.4274509804, blue: 1, alpha: 0.5)
        case 2: color = #colorLiteral(red: 1, green: 0.7176470588, blue: 0.3490196078, alpha: 0.5)
        default: break
        }
        contentView.layer.applySketchShadow(
            color: color,
            alpha: 1.0,
            x: 0,
            y: 2,
            blur: 10,
            spread: 0)
    }
    
    func setGradationColor(_ num: Int) -> CAGradientLayer{
        let gradationColor = CAGradientLayer()
        gradationColor.startPoint = CGPoint(x: 0, y: 0)
        gradationColor.endPoint = CGPoint(x: 1, y: 1)
        gradationColor.locations = [0, 1]
        gradationColor.frame = gradationView.bounds
        switch num {
        case 0: gradationColor.colors = mintColors
        case 1: gradationColor.colors = purpleColors
        case 2: gradationColor.colors = orangeColors
        default: break
        }
        return gradationColor
    }
    
    
}
