//
//  CYHomeViewController.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/3/31.
//  Copyright © 2018年 YX. All rights reserved.
//

import UIKit

class CYHomeViewController: CYBaseViewController {

    @IBOutlet weak var mButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mButton.addTarget(self, action: #selector(buttonAction(_:)), for: UIControlEvents.touchUpInside)
        
        self.navigationItem.title = "首页"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        
        let ctr : CYMineViewController = CYMineViewController.init(nibName: "CYMineViewController", bundle: nil)
        self.pushToViewController(ctr: ctr)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
