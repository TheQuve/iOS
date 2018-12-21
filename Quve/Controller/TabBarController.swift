//
//  TabBarController.swift
//  Quve
//
//  Created by ParkSungJoon on 21/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = #colorLiteral(red: 0.1450980392, green: 0.8823529412, blue: 1, alpha: 1)
        let askImage = UIImage(named: "askIcon")?.withRenderingMode(.alwaysOriginal)
        (tabBar.items![2]).selectedImage = askImage
        (tabBar.items![2]).image = askImage
    }

    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AskQuestionViewController {
            if let controller = storyboard?.instantiateViewController(withIdentifier: "AskQuestionViewController"){
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
            return false
        }
        return true
    }

}
