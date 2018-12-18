//
//  ViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 08/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        setNavigationBar()
        setButtonBarStyle()
        super.viewDidLoad()
        setButtonBarView()
        setCurrentButtonBarItem()
    }
    
    fileprivate func setNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = HomeChildViewController(itemInfo: "떠오르는")
        let child2 = HomeChildViewController(itemInfo: "맞춤")
        let child3 = HomeChildViewController(itemInfo: "실시간 답변완료")
        let child4 = HomeChildViewController(itemInfo: "지식나눔")
        
        let childViewController = [child1, child2, child3, child4]
        
        return childViewController
    }
    
    fileprivate func setButtonBarView() {
        buttonBarView.removeFromSuperview()
        navigationController?.navigationBar.addSubview(buttonBarView)
        buttonBarView.selectedBar.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.8823529412, blue: 1, alpha: 1)
    }
    
    fileprivate func setButtonBarStyle() {
        settings.style.buttonBarLeftContentInset = UIScreen.main.bounds.size.width / 2
        settings.style.buttonBarRightContentInset = UIScreen.main.bounds.size.width / 2
        settings.style.buttonBarItemTitleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarHeight = 1.0
        settings.style.buttonBarItemFont = UIFont(name: "SpoqaHanSans-Bold", size: 14.0)!
    }
    
    fileprivate func setCurrentButtonBarItem() {
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)
            newCell?.label.textColor = #colorLiteral(red: 0.1450980392, green: 0.8823529412, blue: 1, alpha: 1)
        }
    }
}

