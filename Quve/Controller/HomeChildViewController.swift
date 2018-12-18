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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
