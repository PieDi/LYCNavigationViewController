//
//  CYConstantDefine.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/4/2.
//  Copyright © 2018年 YX. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
let PopDuration = 0.12    // 记录pop 动画时间
let PushDuration = 0.12   // 记录push 动画时间



func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}




