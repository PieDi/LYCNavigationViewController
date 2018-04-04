//
//  LYCAddition.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/3/31.
//  Copyright © 2018年 YX. All rights reserved.
//

import UIKit
import Foundation


class LYCAddition: UIView {

    func navigationBarHeight() -> CGFloat {
        return CGFloat(UIApplication.shared.statusBarFrame.size.height+44)
    }

}



let kLYCNavBarBottom:CGFloat = CGFloat(44+UIApplication.shared.statusBarFrame.size.height)


// MARK:  UIColor

var kLYCDefaultNavBarBarTintColorKey : String = "kLYCDefaultNavBarBarTintColorKey"
var kLYCDefaultNavBarBackgroundImageKey : String = "kLYCDefaultNavBarBackgroundImageKey"
var kLYCDefaultNavBarTitleColorKey : String = "kLYCDefaultNavBarTitleColorKey"
var kLYCDefaultStatusBarStyleKey : String = "kLYCDefaultStatusBarStyleKey"
var kLYCDefaultNavBarShadowImageHiddenKey : String = "kLYCDefaultNavBarShadowImageHiddenKey"

extension UIColor{
    
    class func defaultNavBarBarTintColor() -> (UIColor) {
        let color : UIColor? = objc_getAssociatedObject(self, &kLYCDefaultNavBarBarTintColorKey) as? UIColor
        return ((color != nil) ? color! : UIColor.white)
        
    }
    class func lyc_setDefaultNavBarBarTintColor(color:UIColor) -> Void {
        objc_setAssociatedObject(self, &kLYCDefaultNavBarBarTintColorKey, color, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    
    class func defaultNavBarBackgroundImage() -> (UIImage?) {
        let image : UIImage? = objc_getAssociatedObject(self, &kLYCDefaultNavBarBackgroundImageKey) as? UIImage
        return image
        
    }
    class func lyc_setDefaultNavBarBackgroundImage(image:UIImage) -> Void {
        objc_setAssociatedObject(self, &kLYCDefaultNavBarBackgroundImageKey, image, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    class func defaultNavBarTitleColor() -> (UIColor) {
        let color : UIColor? = objc_getAssociatedObject(self, &kLYCDefaultNavBarTitleColorKey) as? UIColor
        return ((color != nil) ? color! : UIColor.white)
        
    }
    class func lyc_setDefaultNavBarTitleColor(color:UIColor) -> Void {
        objc_setAssociatedObject(self, &kLYCDefaultNavBarTitleColorKey, color, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    class func defaultStatusBarStyle() -> (UIStatusBarStyle) {
        let style : UIStatusBarStyle? = objc_getAssociatedObject(self, &kLYCDefaultStatusBarStyleKey) as? UIStatusBarStyle
        return ((style != nil) ? style! : UIStatusBarStyle.default)
        
    }
    class func lyc_setDefaultStatusBarStyle(style:UIStatusBarStyle) -> Void {
        objc_setAssociatedObject(self, &kLYCDefaultStatusBarStyleKey, style, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    
    
    class func defaultNavBarShadowImageHidden() -> (Bool) {
        let hidden : Bool? = objc_getAssociatedObject(self, &kLYCDefaultNavBarShadowImageHiddenKey) as? Bool
        return ((hidden != nil) ? hidden! : false)
        
    }
    class func lyc_setDefaultNavBarShadowImageHidden(hidden:Bool) -> Void {
        objc_setAssociatedObject(self, &kLYCDefaultNavBarShadowImageHiddenKey, hidden, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    class func defaultNavBarBackgroundAlpha() -> (CGFloat) {
        
        return 1.0
        
    }
    
    
    class func transitionColor(fromColor:UIColor,toColor:UIColor,percent:CGFloat) -> (UIColor) {
        
        var fromRed : CGFloat = 0.0
        var fromGreen:CGFloat = 0.0
        var fromBlue:CGFloat = 0.0
        var fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        
        var toRed : CGFloat = 0
        var toGreen :CGFloat = 0
        var toBlue : CGFloat = 0
        var toAlpha : CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha:&toAlpha )
        
        let newRed :CGFloat = fromRed + (toRed - fromRed) * percent
        let newGreen :CGFloat = fromGreen + (toGreen - fromGreen) * percent
        let newBlue :CGFloat = fromBlue + (toBlue - fromBlue) * percent;
        let newAlpha :CGFloat = fromAlpha + (toAlpha - fromAlpha) * percent;
        return UIColor.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
    
    class func transitionAlpha(fromAlpha:CGFloat,toAlpha:CGFloat,percent:CGFloat) -> (CGFloat) {
        return fromAlpha + (toAlpha - fromAlpha) * percent
    }
    
}

// MARK:  UIViewController

var kLYCNavBarBackgroundImageKey : String = "kLYCNavBarBackgroundImageKey"   // 导航条的背景图片
var kLYCCustomNavBarKey : String = "kLYCCustomNavBarKey" // 导航条
var kLYCNavBarBarTintColorKey : String = "kLYCNavBarBarTintColorKey" // 导航条的背景颜色
var kLYCNavBarBackgroundAlphaKey : String = "kLYCNavBarBackgroundAlphaKey" // 导航条的背景透明度
var kLYCNavBarTitleColorKey : String = "kLYCNavBarTitleColorKey"  // 导航条title 颜色
var kLYCStatusBarStyleKey : String = "kLYCStatusBarStyleKey"  // 状态栏风格
var kLYCPushToCurrentVCFinishedKey : String = "kLYCPushToCurrentVCFinishedKey"  //
var kLYCPushToNextVCFinishedKey : String = "kLYCPushToNextVCFinishedKey"  //
var kLYCNavBarShadowImageHiddenKey : String = "kLYCNavBarShadowImageHiddenKey"  // 隐藏导航条下面的横线



extension UIViewController{
    
    class func controllerMethodSwizzling() -> Void {
        let needSwizzleSelectors = [#selector(viewWillAppear(_:)),#selector(viewWillDisappear(_:)),#selector(viewDidAppear(_:))]
        
        let swizzleSelectors = [#selector(lyc_viewWillAppear),#selector(lyc_viewWillDisappear),#selector(lyc_viewDidAppear)]
        
        var index = 0
        
        for item in needSwizzleSelectors {
            
            let originalSelector = item
            let swizzledSelector = swizzleSelectors[index]
            index += 1
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!);
            }
            
        }
        
        
        
        
    }
    
    @objc func lyc_viewWillAppear(animated: Bool) -> Void {
//        self.setPushToNextVCFinished(isFinished: false)
//    self.navigationController?.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: self.lyc_navBarBarTintColor())
//
//    self.navigationController?.setNeedsNavigationBarUpdateForTitleColor(titleColor: self.lyc_navBarTitleColor())
//
//        self.lyc_viewWillAppear(animated: animated)
        
        
    }
    @objc func lyc_viewWillDisappear(animated: Bool) -> Void {
        self.setPushToNextVCFinished(isFinished: true)
        self.lyc_viewWillDisappear(animated: animated)
        
    }
    
    @objc func lyc_viewDidAppear(animated: Bool) -> Void {
        
        self.setPushToNextVCFinished(isFinished: false)
        
        let barBgImage:UIImage? = self.lyc_navBarBackgroundImage()
        if barBgImage != nil {
            self.navigationController?.setNeedsNavigationBarUpdateForBarBackgroundImage(backgroundImage: barBgImage!)
        }else{
            self.navigationController?.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: self.lyc_navBarBarTintColor())
        }
        
        self.navigationController?.setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha: self.lyc_navBarBackgroundAlpha())
        self.navigationController?.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: self.lyc_navBarBarTintColor())
        self.navigationController?.setNeedsNavigationBarUpdateForTitleColor(titleColor: self.lyc_navBarTitleColor())
        self.navigationController?.setNeedsNavigationBarUpdateForShadowImageHidden(hidden: self.lyc_navBarShadowImageHidden())
        
        self.lyc_viewDidAppear(animated: animated)
        
    }
    
    
    
    
    
    
    func pushToCurrentVCFinished() -> (Bool) {
        let isFinished: Bool? = objc_getAssociatedObject(self, &kLYCPushToCurrentVCFinishedKey) as? Bool
        return ((isFinished != nil) ? isFinished! : false)
        
    }
    func setPushToCurrentVCFinished(isFinished : Bool) -> Void {
        objc_setAssociatedObject(self, &kLYCPushToCurrentVCFinishedKey, isFinished, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    
    func pushToNextVCFinished() -> (Bool) {
        let isFinished : Bool? = objc_getAssociatedObject(self, &kLYCPushToNextVCFinishedKey) as? Bool
        return ((isFinished != nil) ? isFinished! : false)
    }
    
    func setPushToNextVCFinished(isFinished:Bool) -> Void {
        objc_setAssociatedObject(self, &kLYCPushToNextVCFinishedKey, isFinished, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }

    
    
    /**
     设置导航条背景图片
     */
    func lyc_navBarBackgroundImage() -> (UIImage?) {
        let barBackImage: UIImage? = objc_getAssociatedObject(self, kLYCNavBarBackgroundImageKey) as? UIImage
        // 未完成
        return ((barBackImage == nil) ?  UIColor.defaultNavBarBackgroundImage(): barBackImage)
        
    }
    
    
    func lyc_setNavBarBackgroundImage(image: UIImage) -> Void{
        if self.lyc_customNavBar().isKind(of: UINavigationBar.self) {
            let navBar:UINavigationBar = self.lyc_customNavBar() as!UINavigationBar
            navBar.lyc_setBackgroundImage(image: image)
            
        }else{
            objc_setAssociatedObject(self, kLYCNavBarBackgroundImageKey,image,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    /**
     设置导航条背景颜色
     */
    func lyc_navBarBarTintColor() -> (UIColor) {
        let barTintColor :UIColor? = objc_getAssociatedObject(self, &kLYCNavBarBarTintColorKey) as? UIColor
        return ((barTintColor != nil) ? barTintColor! :UIColor.white)
    }
    
    func lyc_setNavBarBarTintColor(color:UIColor) -> Void {
        objc_setAssociatedObject(self, &kLYCNavBarBarTintColorKey, color, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if self.lyc_customNavBar().isKind(of: UINavigationBar.self) {
            let navBar :UINavigationBar = self.lyc_customNavBar() as! UINavigationBar
            //  未完成
            navBar.lyc_setBackgroundColor(color: color)
        } else {
            if self.pushToCurrentVCFinished() == true && self.pushToNextVCFinished() == false{
                
                //  未完成
                self.navigationController?.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: color)
                
            }
        }
    }
    
    /**
     设置导航条背景透明度
     */
    func lyc_navBarBackgroundAlpha() -> (CGFloat) {
        let barBackgroundAlpha:CGFloat? = objc_getAssociatedObject(self, &kLYCNavBarBackgroundAlphaKey) as? CGFloat
        return ((barBackgroundAlpha != nil) ? barBackgroundAlpha! : 1.0)
    }
    
    func lyc_setNavBarBackgroundAlpha(alpha: CGFloat) -> Void {
        objc_setAssociatedObject(self, &kLYCNavBarBackgroundAlphaKey,alpha,objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        if self.lyc_customNavBar().isKind(of: UINavigationBar.self) {
            let navBar :UINavigationBar = self.lyc_customNavBar() as! UINavigationBar
            //  未完成
            navBar.lyc_setBackgroundAlpha(alpha: alpha)
        } else {
            if self.pushToCurrentVCFinished() == true && self.pushToNextVCFinished() == false{
                
                //  未完成
                self.navigationController?.setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha: alpha)
                
            }
            
        }
    }
    
    /**
     设置导航条title 颜色
     */
    func lyc_navBarTitleColor() -> (UIColor) {
        let titleColor: UIColor? = objc_getAssociatedObject(self, &kLYCNavBarTitleColorKey) as? UIColor
        return ((titleColor != nil) ? titleColor! : UIColor.white)
        
    }
    
    func lyc_setNavBarTitleColor(color: UIColor) -> Void {
        objc_setAssociatedObject(self, &kLYCNavBarTitleColorKey, color, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if self.lyc_customNavBar().isKind(of: UINavigationBar.self) {
            let navBar :UINavigationBar = self.lyc_customNavBar() as! UINavigationBar
            let titleAttributes:Dictionary = [NSAttributedStringKey.foregroundColor: color]
            
            navBar.titleTextAttributes = titleAttributes
            
        } else {
            
            if self.pushToNextVCFinished() == false{
                // 未完成
                self.navigationController?.setNeedsNavigationBarUpdateForTitleColor(titleColor: color)
            }
        }
    }
    
    
    
    /**
     设置导航条信息
     */
    func lyc_customNavBar() -> (UIView) {
        let navBar: UIView? = objc_getAssociatedObject(self, &kLYCCustomNavBarKey) as? UIView
        return ((navBar != nil) ? navBar! : UIView.init())
    }
    func lyc_setCustomNavBar(navBar:UINavigationBar) -> Void {
        objc_setAssociatedObject(self, &kLYCCustomNavBarKey,navBar,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    
    
    func lyc_statusBarStyle() -> (UIStatusBarStyle) {
        let style:UIStatusBarStyle? = objc_getAssociatedObject(self, &kLYCStatusBarStyleKey) as? UIStatusBarStyle
        return ((style != nil) ? style! :UIStatusBarStyle.default)
        
    }
    
    func lyc_setStatusBarStyle(style:UIStatusBarStyle) -> Void {
        objc_setAssociatedObject(self, &kLYCStatusBarStyleKey, style, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func lyc_setNavBarShadowImageHidden(hidden:Bool) -> Void {
        
        objc_setAssociatedObject(self, &kLYCNavBarShadowImageHiddenKey, hidden, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    func lyc_navBarShadowImageHidden() -> (Bool) {
        let hidden: Bool? = objc_getAssociatedObject(self, &kLYCNavBarShadowImageHiddenKey) as? Bool
        return ((hidden != nil) ? hidden! : UIColor.defaultNavBarShadowImageHidden())
        
    }
    
    
}

// MARK:  UINavigationBar

var kLYCBackgroundViewKey : String = "kLYCBackgroundViewKey"
var kLYCBackgroundImageViewKey : String = "kLYCBackgroundImageViewKey"




extension UINavigationBar: UINavigationBarDelegate{
    
    class func defaultNavBarBackgroundImage() -> (UIImage) {
        let image = objc_getAssociatedObject(self, &kLYCNavBarBackgroundImageKey) as! UIImage
        return image
        
    }
    
    
    func backgroundView() -> (UIView?) {
        let navBar: UIView? = objc_getAssociatedObject(self, &kLYCBackgroundViewKey) as? UIView
        return navBar
    }
    func setBackgroundView(backgroundView:UIView) -> Void {
        objc_setAssociatedObject(self, &kLYCBackgroundViewKey,backgroundView,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    func backgroundImageView() -> (UIImageView?) {
        let backgroundImageView: UIImageView? = objc_getAssociatedObject(self, &kLYCBackgroundImageViewKey) as? UIImageView
        return backgroundImageView
    }
    
    func setBackgroundImageView(backgroundImageView:UIImageView) -> Void {
        objc_setAssociatedObject(self, &kLYCBackgroundImageViewKey,backgroundImageView,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    func lyc_setBackgroundImage(image:UIImage) -> Void {
        
        var backgroundView:UIView? = self.backgroundView()
        backgroundView?.removeFromSuperview()
        backgroundView = nil
        
        
        
        
        if self.backgroundImageView() == nil {
            self.setBackgroundImage(UIImage.init(), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
            let backgroundImageView = UIImageView.init(frame: CGRect.init(x:0,y:0,width:self.bounds.size.width,height:kLYCNavBarBottom))
            self.setBackgroundImageView(backgroundImageView: backgroundImageView)
            
            self.subviews.first?.insertSubview(backgroundImageView, at: 0)
            
        }
        
        self.backgroundImageView()?.image = image
        
    }
    
    func lyc_setBackgroundColor(color:UIColor) -> Void {
        var backgroundImageView:UIImageView? = self.backgroundImageView()
        backgroundImageView?.removeFromSuperview()
        backgroundImageView = nil
        
        
        if self.backgroundView() == nil {
            
            self.setBackgroundImage(UIImage.init(), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
            self.setBackgroundView(backgroundView: UIView.init(frame: CGRect.init(x:0,y:0,width:self.bounds.size.width,height:kLYCNavBarBottom)))
            
            self.subviews.first?.insertSubview(self.backgroundView()!, at: 0)
            
        }
        self.backgroundView()?.backgroundColor = color
        
    }
    
    
    
    
    func lyc_setBackgroundAlpha(alpha:CGFloat) -> Void {
        let backgroundView = self
        .subviews.first
        backgroundView?.alpha = alpha
        
    }
    
    func lyc_setTitleTextAttributes(titleTextAttributes:Dictionary<String, Any>) -> Void {
        var newTitleTextAttributes:Dictionary? = Dictionary<String, Any>()
        
        for (key,value) in titleTextAttributes {
            newTitleTextAttributes![key] = value
        }
        if newTitleTextAttributes == nil {
            return
        }
        
        let originTitleTextAttributes:Dictionary? = self.titleTextAttributes
        if originTitleTextAttributes == nil {
            self.lyc_setTitleTextAttributes(titleTextAttributes: newTitleTextAttributes!)
            return
        }
        
        var titleColor:UIColor?
        for key in (originTitleTextAttributes?.keys)! {
            if key == NSAttributedStringKey.foregroundColor{
                titleColor = originTitleTextAttributes?[key] as? UIColor
            }
        }
        
        if titleColor == nil {
            self.lyc_setTitleTextAttributes(titleTextAttributes: newTitleTextAttributes!)
            return
        }
        
        newTitleTextAttributes!["NSAttributedStringKey.foregroundColor"] = titleColor
        self.lyc_setTitleTextAttributes(titleTextAttributes: newTitleTextAttributes!)
        
        
    }
    
}



/* UINavigationController */
let lycPopDuration = 0.12;
var lycPopDisplayCount = 0;

let lycPushDuration = 0.1;
var lycPushDisplayCount = 0;

extension UINavigationController{
    
    
    
    func lycPopProgress() -> (CGFloat) {
        let  all = 60 * lycPopDuration
        let current = min(all, Double(CGFloat(lycPopDisplayCount)))
        return (CGFloat)(current/all)
        
    }
    
    func lycPushProgress() -> (CGFloat) {
        let  all = 60 * lycPushDuration
        let current = min(all, Double(lycPushDisplayCount))
        return (CGFloat)(current/all)
    }
    
    func preferredStatusBarStyle()->(UIStatusBarStyle){
        return (self.topViewController?.lyc_statusBarStyle())!
    }
    
    func setNeedsNavigationBarUpdateForBarBackgroundImage(backgroundImage:UIImage) -> Void {
        self.navigationBar.lyc_setBackgroundImage(image: backgroundImage)
    }
    
    func setNeedsNavigationBarUpdateForBarTintColor(barTintColor:UIColor) -> Void {
        self.navigationBar.lyc_setBackgroundColor(color: barTintColor)
    }
    
    func setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha:CGFloat) -> Void {
        self.navigationBar.lyc_setBackgroundAlpha(alpha: barBackgroundAlpha)
    }
    
    func setNeedsNavigationBarUpdateForTitleColor(titleColor:UIColor) -> Void {
        let titleTextAttributes:Dictionary? = self.navigationBar.titleTextAttributes
        if titleTextAttributes == nil {
            self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor]
            return
        }
        var newTitleTextAttributes = titleTextAttributes
        newTitleTextAttributes![NSAttributedStringKey.foregroundColor] = titleColor
        self.navigationBar.titleTextAttributes = newTitleTextAttributes
        
    }

    func setNeedsNavigationBarUpdateForShadowImageHidden(hidden:Bool) -> Void {
        self.navigationBar.shadowImage = (hidden == true) ? UIImage.init() : nil
    }
    
    
    func updateNavigationBarWithFromVCprogress(fromVC:UIViewController, toVC: UIViewController, progress:CGFloat) -> Void {
        
        // change navBarBarTintColor
        let fromBarTintColor:UIColor = fromVC.lyc_navBarBarTintColor();
        
        let toBarTintColor:UIColor = toVC.lyc_navBarBarTintColor();
        let newBarTintColor:UIColor = UIColor.transitionColor(fromColor: fromBarTintColor, toColor: toBarTintColor, percent: progress)
        self.setNeedsNavigationBarUpdateForBarTintColor(barTintColor: newBarTintColor)
        
        
        
        // change navBarTitleColor
        let fromTitleColor:UIColor = fromVC.lyc_navBarTitleColor();
        let toTitleColor:UIColor = toVC.lyc_navBarTitleColor();
        let newTitleColor:UIColor = UIColor.transitionColor(fromColor: fromTitleColor, toColor: toTitleColor, percent: progress)
        self.setNeedsNavigationBarUpdateForTitleColor(titleColor: newTitleColor)
        
        // change navBar _UIBarBackground alpha
        let fromBarBackgroundAlpha:CGFloat = fromVC.lyc_navBarBackgroundAlpha();
        let toBarBackgroundAlpha : CGFloat = toVC.lyc_navBarBackgroundAlpha();
        let newBarBackgroundAlpha : CGFloat = UIColor.transitionAlpha(fromAlpha: fromBarBackgroundAlpha, toAlpha: toBarBackgroundAlpha, percent: progress);
        self.setNeedsNavigationBarUpdateForBarBackgroundAlpha(barBackgroundAlpha: newBarBackgroundAlpha)
    }
    
    
    class func navigationCtrMethodSwizzling() -> Void {
        
        
        let needSwizzleSelectors = [#selector(pushViewController),
                                    #selector(popViewController),#selector(popToViewController), #selector(popToRootViewController)]
        
        
        let swizzleSelectors = [#selector(lyc_pushViewController),#selector(lyc_popViewController),#selector(lyc_popToViewController),#selector(lyc_popToRootViewController)]
        
        var index = 0
        
                for item in needSwizzleSelectors {
        
        
        
                    let originalSelector = item
                    let swizzledSelector = swizzleSelectors[index]
                    index += 1
        
                    let originalMethod = class_getInstanceMethod(self, originalSelector)
                    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        
        
        
                    let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
                    if didAddMethod {
                        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
                    } else {
                        method_exchangeImplementations(originalMethod!, swizzledMethod!);
                    }
        
                }
        
        
    }
    
    
    
    @objc func lyc_pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let displayLink: CADisplayLink = CADisplayLink.init(target: self, selector: #selector(pushNeedDisplay))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        CATransaction.setCompletionBlock {
            displayLink.invalidate()
            lycPushDisplayCount = 0
        viewController.setPushToCurrentVCFinished(isFinished: true)
            
        }
        
        CATransaction.setAnimationDuration(lycPushDuration)
        CATransaction.begin()
        self.lyc_pushViewController(viewController, animated: animated)
        CATransaction.commit()
       
    }
    
    @objc func lyc_popViewController(animated: Bool) -> UIViewController? {
        
        let displayLink: CADisplayLink = CADisplayLink.init(target: self, selector: #selector(popNeedDisplay))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        CATransaction.setCompletionBlock {
            displayLink.invalidate()
            lycPopDisplayCount = 0
        }
        
    CATransaction.setAnimationDuration(CFTimeInterval(lycPopDuration))
        CATransaction.begin()
        let ctr  = self.lyc_popViewController(animated: animated)!
        
        CATransaction.commit()
        return ctr

    }
    
    @objc func lyc_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        let displayLink: CADisplayLink = CADisplayLink.init(target: self, selector: #selector(popNeedDisplay))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        CATransaction.setCompletionBlock {
            displayLink.invalidate()
            lycPopDisplayCount = 0
        }
        
    CATransaction.setAnimationDuration(CFTimeInterval(lycPopDuration))
        CATransaction.begin()
        let vcs :Array<UIViewController> = self.lyc_popToViewController(viewController, animated: animated)!
        
        CATransaction.commit()
        return vcs
    }
    
    @objc func lyc_popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        let displayLink: CADisplayLink = CADisplayLink.init(target: self, selector: #selector(popNeedDisplay))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        CATransaction.setCompletionBlock {
            displayLink.invalidate()
            lycPopDisplayCount = 0
        }
        
        CATransaction.setAnimationDuration(CFTimeInterval(lycPopDuration))
        CATransaction.begin()
        let vcs = self.lyc_popToRootViewController(animated: animated)
        
        CATransaction.commit()
        return vcs
        
    }
    
    
    @objc func pushNeedDisplay() -> Void {
        if self.topViewController != nil && self.topViewController?.transitionCoordinator != nil {
            lycPushDisplayCount += 1
            let pushProgress:CGFloat = self.lycPushProgress()
            let fromVC:UIViewController = (self.topViewController?.transitionCoordinator?.viewController(forKey: UITransitionContextViewControllerKey.from))!
            let toVC:UIViewController = (self.topViewController?.transitionCoordinator?.viewController(forKey: UITransitionContextViewControllerKey.to))!
            self.updateNavigationBarWithFromVCprogress(fromVC: fromVC, toVC: toVC, progress: pushProgress)
            
        }
    }
    
    
    @objc func popNeedDisplay() -> Void {
        if self.topViewController != nil && self.topViewController?.transitionCoordinator != nil {
            lycPopDisplayCount += 1
            let popProgress:CGFloat = self.lycPopProgress()
            let fromVC:UIViewController = (self.topViewController?.transitionCoordinator?.viewController(forKey: UITransitionContextViewControllerKey.from))!
            let toVC:UIViewController = (self.topViewController?.transitionCoordinator?.viewController(forKey: UITransitionContextViewControllerKey.to))!
            self.updateNavigationBarWithFromVCprogress(fromVC: fromVC, toVC: toVC, progress: popProgress)
            
        }
    }
}


