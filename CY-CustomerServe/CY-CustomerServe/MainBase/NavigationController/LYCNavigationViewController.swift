//
//  LYCNavigationViewController.swift
//  CY-CustomerServe
//
//  Created by PieDi on 2018/3/31.
//  Copyright © 2018年 YX. All rights reserved.
//

import UIKit

class LYCNavigationViewController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    
    let panGesture:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init()
    lazy var screenshotImgs = Array<Any>()
    var coverView:UIView?
    var screenshotImgView:UIImageView?
    var nextVCScreenShotImg:UIImage?
    lazy var animationController = NavigationAnimation.init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.navigationBar.tintColor = UIColorFromRGB(rgbValue: 0xF54E56)
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
        self.view.layer.shadowOpacity = 0.6
        
        self.panGesture.addTarget(self, action: #selector(aaaa))
        self.panGesture.edges = UIRectEdge.left
        self.view.addGestureRecognizer(self.panGesture)
        
        // 创建截图的ImageView
        self.screenshotImgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        
        // 创建截图上面的黑色半透明遮罩
        self.coverView = UIView.init()
        self.coverView?.frame = (self.screenshotImgView?.frame)!
        self.coverView?.backgroundColor = UIColor.black

    }

    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animationController.navigationOperation = operation
        self.animationController.setNavigationController(navigationController: self)
        
        return self.animationController
    }
    
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
    
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let index: NSInteger = self.viewControllers.count

        
        if self.screenshotImgs.count >= index-1 {
            self.screenshotImgs.removeLast()
        }
        return super.popViewController(animated: animated)
        
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        var removeCount: NSInteger = 0
        for i in self.viewControllers.count-1 ... 0 {
            
            if viewController == self.viewControllers[i]{
                break
            }

            self.screenshotImgs.removeLast()
            removeCount += 1
        }
        self.animationController.removeCount = removeCount
    
        return super.popToViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        self.screenshotImgs.removeAll()
        return super.popToRootViewController(animated: animated)
    }
    
    
    
    @objc func aaaa(panGestureRec: UIScreenEdgePanGestureRecognizer) -> Void {
        
        
        // 如果当前显示的控制器已经是根控制器了，不需要做任何切换动画,直接返回
        if self.visibleViewController == self.viewControllers[0] {
            return
        }
    
        switch panGestureRec.state {
        case UIGestureRecognizerState.began:
            self.dragBegin()
            break
        case UIGestureRecognizerState.cancelled: break
        case UIGestureRecognizerState.failed: break
        case UIGestureRecognizerState.ended:
            self.dragEnd()
            break
        default:
            self.dragging(pan: panGestureRec)
            break
        }
    }
    
    
    

    
    
    
    
    func dragBegin() -> Void {
        self.view.window?.insertSubview(self.screenshotImgView!, at: 0)
        self.view.window?.insertSubview(self.coverView!, aboveSubview: self.screenshotImgView!)
        self.screenshotImgView?.image = self.screenshotImgs.last as? UIImage
    }
    
    
    func dragging(pan:UIPanGestureRecognizer) -> Void {

        
        let offsetX: CGFloat = (pan.translation(in: self.view).x)
        if offsetX > 0 {
            self.view.transform = CGAffineTransform.init(translationX:offsetX ,y:0)
        }
        
        // 计算目前手指拖动位移占屏幕总的宽高的比例,当这个比例达到3/4时, 就让imageview完全显示，遮盖完全消失
        let currentTranslateScaleX : Double =  Double(offsetX/ScreenWidth)
        if offsetX < ScreenWidth {
            self.screenshotImgView?.transform = CGAffineTransform.init(translationX:(offsetX - ScreenWidth) * 0.6 ,y:0)
        }
        
        // 让遮盖透明度改变,直到减为0,让遮罩完全透明,默认的比例-(当前平衡比例/目标平衡比例)*默认的比例
        let alpha : CGFloat = CGFloat(0.6*(1-(currentTranslateScaleX/0.75)))
        self.coverView?.alpha = CGFloat(alpha)
        
    }
    
    func dragEnd() -> Void {
        let translateX : CGFloat = self.view.transform.tx
        if translateX <= 40 {
            
            // 如果手指移动的距离还不到屏幕的一半,往左边挪 (弹回)
            UIView.animate(withDuration: 0.3, animations: {
            // 重要~~让被右移的view弹回归位,只要清空transform即可办到
            self.view.transform = CGAffineTransform.identity
            // 让imageView大小恢复默认的translation
            self.screenshotImgView?.transform = CGAffineTransform.init(translationX: -ScreenWidth ,y:0)
            // 让遮盖的透明度恢复默认的alpha 1.0
            self.coverView?.alpha = 0.6
                
            }, completion: { (finished: Bool) in
                
                // 重要,动画完成之后,每次都要记得 移除两个view,下次开始拖动时,再添加进来
                self.screenshotImgView?.removeFromSuperview()
                self.coverView?.removeFromSuperview()
            })
            
        }else{
            // 如果手指移动的距离还超过了屏幕的一半,往右边挪
            UIView.animate(withDuration: 0.3, animations: {
                // 让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform
                self.view.transform = CGAffineTransform.init(translationX:  ScreenWidth,y:0)
                // 让imageView位移还原
                self.screenshotImgView?.transform = CGAffineTransform.init(translationX: 0 ,y:0)
                // 让遮盖alpha变为0,变得完全透明
                self.coverView?.alpha = 0
                
            }, completion: { (finished:Bool) in
                // 重要~~让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform,不然下次再次开始drag时会出问题,因为view的transform没有归零
                self.view.transform = CGAffineTransform.identity
                
                self.screenshotImgView?.removeFromSuperview()
                self.coverView?.removeFromSuperview()
                 // 执行正常的Pop操作:移除栈顶控制器,让真正的前一个控制器成为导航控制器的栈顶控制器
                self.popViewController(animated: false)
                // 重要~记得这时候,可以移除截图数组里面最后一张没用的截图了
                self.animationController.removeLastScreenShot()
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK:  处理导航条问题
    
    

}
