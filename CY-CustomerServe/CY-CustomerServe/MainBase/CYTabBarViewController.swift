//
//  CYTabBarViewController.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/3/31.
//  Copyright © 2018年 YX. All rights reserved.
//

import UIKit

class CYTabBarViewController: UITabBarController {

    var viewCtrArray = [UINavigationController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       self.setSubsViewController(ctr: CYHomeViewController.init(nibName: "CYHomeViewController", bundle: nil), title: "首页", unSelectImage: "", selectImage: "")
        self.setSubsViewController(ctr: CYHomeViewController(), title: "第二页", unSelectImage: "", selectImage: "")
        self.setSubsViewController(ctr: CYHomeViewController(), title: "第三页", unSelectImage: "", selectImage: "")
        self.viewControllers = viewCtrArray
        
    }

    func setSubsViewController(ctr: CYBaseViewController, title: String, unSelectImage:String, selectImage:String) -> () {
        
        let navigaCtr = LYCNavigationViewController(rootViewController: ctr)
        navigaCtr.tabBarItem.title = title
        navigaCtr.tabBarItem.image = UIImage.init(named: unSelectImage)
        navigaCtr.tabBarItem.selectedImage = UIImage.init(named: selectImage)
//        let tabBarItem = UITabBarItem(title: title, image: UIImage.init(named: unSelectImage), selectedImage: UIImage.init(named: selectImage))
//        navigaCtr.tabBarItem = tabBarItem
        
        viewCtrArray.append(navigaCtr)
        
        
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
