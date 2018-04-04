//
//  CYBaseViewController.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/3/31.
//  Copyright © 2018年 YX. All rights reserved.
//

import UIKit



class CYBaseViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.lyc_setNavBarBarTintColor(color: UIColor.red)
        self.lyc_setNavBarTitleColor(color: UIColor.white)
        self.lyc_setNavBarShadowImageHidden(hidden: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func pushToViewController(ctr :CYBaseViewController) -> () {
        
        if (self.navigationController != nil) {
            self.navigationController?.pushViewController(ctr, animated: true)
        }else{
            self .present(ctr, animated: true) {
                
            }
        }
    }


}

extension CYBaseViewController{
    
}


