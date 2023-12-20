import UIKit
import CoreGraphics

extension CGFloat {

    //屏幕宽度
    public static var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    //屏幕高度
    public static var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    
    //屏幕倍率
    public static var screenScale: CGFloat {
        get {
            return UIScreen.main.scale
        }
    }
    
    //状态栏高度
    public static var statusBarHeight: CGFloat {
        get {
            return CGRect.statusBarFrame.height
        }
    }
    
    //安全区顶高度
    public static var safeAreaTop: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return UIEdgeInsets.safeAreaInsets.top
            } else {
                return 0.0
            }
        }
    }
    
    //安全区底高度
    public static var safeAreaBottom: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return UIEdgeInsets.safeAreaInsets.bottom
            } else {
                return 0.0
            }
        }
    }
    
}

extension CGRect {
    
    //状态栏尺寸
    public static var statusBarFrame: CGRect {
        var statusBarFrame = CGRect.zero
        if #available(iOS 13.0, *) {
            guard let window = UIApplication.shared.windows.first else { return .zero }
            guard let windowScene = window.windowScene else { return .zero }
            guard let statusBarManager = windowScene.statusBarManager else { return .zero }
            statusBarFrame = statusBarManager.statusBarFrame
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        return statusBarFrame
    }
    
}

extension UIEdgeInsets {
    
    //安全区域尺寸
    @available(iOS 11.0, *)
    public static var safeAreaInsets: UIEdgeInsets {
        guard let window = UIApplication.shared.windows.first else { return .zero }
        guard let rootVC = window.rootViewController else { return .zero }
        return rootVC.view.safeAreaInsets
    }
    
}
