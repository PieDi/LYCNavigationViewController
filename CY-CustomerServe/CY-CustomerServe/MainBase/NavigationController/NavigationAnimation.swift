//
//  NavigationAnimation.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/3/31.
//  Copyright © 2018年 YX. All rights reserved.
//

import UIKit

class NavigationAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    
    public var navigationOperation : UINavigationControllerOperation?
    public var navigationController : LYCNavigationViewController?
    public var removeCount : NSInteger = 0
    public lazy var screenShotArray = Array<Any>()
    
    
    /**
     类的初始化方法
     */
    class func AnimationControllerWithOperation(operation:UINavigationControllerOperation) -> (NavigationAnimation) {
        let animationCtr = NavigationAnimation.init()
        animationCtr.navigationOperation = operation
        return animationCtr
    }
    
    class func AnimationControllerWithOperation(operation:UINavigationControllerOperation,navigationController:LYCNavigationViewController) -> (NavigationAnimation) {
        
        let animationCtr = NavigationAnimation.init()
        animationCtr.navigationOperation = operation
        animationCtr.navigationController = navigationController
        
        navigationController.screenshotImgs = animationCtr.screenShotArray
        
        return animationCtr
    }
    
    public var isTabbarExist:Bool! = false
    func setNavigationController(navigationController:LYCNavigationViewController) -> Void {
        self.navigationController = navigationController
        let beyondVC: UIViewController? = self.navigationController?.view.window?.rootViewController
        
        if self.navigationController?.tabBarController == beyondVC {
            self.isTabbarExist = true
        }else{
            self.isTabbarExist = false
        }
        
    }
    
    
    
    /**
     调用此方法删除数组最后一张截图 (调用pop手势或一次pop多个控制器时使用)
     */
    func removeLastScreenShot() -> Void {
        self.screenShotArray.removeLast()
    }
    
    /**
     移除全部屏幕截图
     */
    func removeAllScreenShot() -> Void {
        self.screenShotArray.removeAll()
    }
    
    /**
     从截屏数组尾部移除指定数量的截图
     */
    func removeLastScreenShotWithNumber(number:Int) -> Void {

        for _ in 0...number {
            self.screenShotArray.removeLast()
        }
        
    }
    
    
    func screenShot() -> (UIImage) {
        let beyondVC: UIViewController? = self.navigationController?.view.window?.rootViewController
        let size:CGSize = (beyondVC?.view.bounds.size)!
        
        // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        // 要裁剪的矩形范围
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        //判读是导航栏是否有上层的Tabbar  决定截图的对象
        if self.isTabbarExist! {
            beyondVC?.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }else{
            self.navigationController?.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }
        
        let snapshot:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return snapshot
        
    }
    
    
    
    
    /* 代理方法，处理push  和  pop  动画效果*/
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let screentImgView: UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        let  screenImg: UIImage = self.screenShot()
        screentImgView.image = screenImg
        
        let fromViewController: UIViewController = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.from)!
        let toViewController: UIViewController = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.to)!
        let toView:UIView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        var fromViewEndFrame : CGRect = transitionContext.finalFrame(for: fromViewController)
        fromViewEndFrame.origin.x = ScreenWidth
        var fromViewStartFrame = fromViewEndFrame
        
        let toViewEndFrame:CGRect = transitionContext.finalFrame(for: toViewController)
        let toViewStartFrame = toViewEndFrame
        
        let containerView:UIView = transitionContext.containerView
        
        if self.navigationOperation == UINavigationControllerOperation.push {
            self.screenShotArray.append(screenImg)
            
            
            
            for item in self.screenShotArray {
                self.navigationController?.screenshotImgs.append(item)
            }
            
            //这句非常重要，没有这句，就无法正常Push和Pop出对应的界面
            containerView.addSubview(toView)
            toView.frame = toViewStartFrame
            
            
            //将截图添加到导航栏的View所属的window上
        self.navigationController?.view.window?.insertSubview(screentImgView, at: 0)
            
            self.navigationController?.view.transform = CGAffineTransform(translationX: ScreenWidth, y: 0)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.navigationController?.view.transform = CGAffineTransform(translationX:0,y:0)
            }, completion: {(finished:Bool) in
                screentImgView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }
        
        if self.navigationOperation == UINavigationControllerOperation.pop {
            
            fromViewStartFrame.origin.x = 0
            containerView.addSubview(toView)
            
            if self.removeCount > 0{
                for index in 0...self.removeCount{
                    if index == self.removeCount-1{
                        
                        self.removeCount = 0
                        break
                    }else{
                        self.screenShotArray.removeLast()
                    }
                }
            }
            
            
            screentImgView.layer.shadowColor = UIColor.black.cgColor
            screentImgView.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
            screentImgView.layer.shadowOpacity = 0.6
        self.navigationController?.view.window?.addSubview(screentImgView)
            
            UIView.animate(withDuration: 0.4, animations: {
                
                screentImgView.center = CGPoint.init(x: ScreenWidth * 3 / 2, y: ScreenHeight / 2)
                
                
                
            }, completion: {(finished:Bool) in
                screentImgView.removeFromSuperview()
                transitionContext.completeTransition(true)
                self.screenShotArray.removeLast()
            })
            
            
        }
        
        
        
    }
    

}
