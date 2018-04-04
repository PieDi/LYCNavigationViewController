//
//  CYMineViewController.swift
//  CY-CustomerServe
//
//  Created by lyc on 2018/4/4.
//  Copyright © 2018年 PieDi. All rights reserved.
//

import UIKit

class CYMineViewController: CYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.lyc_setNavBarBarTintColor(color: UIColor.green)
        self.lyc_setNavBarShadowImageHidden(hidden: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
