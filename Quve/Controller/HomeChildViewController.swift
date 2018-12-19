//
//  HomeChildViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 17/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeChildViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemInfo: IndicatorInfo = "View"
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        registerCollectionViewCell()
        setCollectionViewLayout()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    fileprivate func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let screenSize = self.view.frame.size
        layout.itemSize = CGSize(width: screenSize.width, height: screenSize.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    fileprivate func registerCollectionViewCell(){
        let nibName = UINib(nibName: "HomeCollectionListCell", bundle: Bundle.main)
        collectionView.register(nibName, forCellWithReuseIdentifier: "HomeCollectionListCell")
    }
}

extension HomeChildViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionListCell", for: indexPath) as! HomeCollectionListCell
        cell.titleLabel.text = "테스트"
        
        return cell
    }
    
}
