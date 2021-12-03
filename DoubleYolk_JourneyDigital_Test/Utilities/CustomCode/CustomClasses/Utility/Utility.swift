//
//  Utility.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.


import Foundation
import UIKit

/// Utility class for application
public struct Utility {

    static var shared = Utility()


    ///  Most top view controller (if applicable).
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }

    /// This method will return a Top Most View Controller (currectly visible) of the application's window which you can use.
    ///
    /// - Returns: Object of the UIViewController
    public func topMostController() -> UIViewController? {

        //        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        //        while (topController.presentedViewController != nil) {
        //            topController = topController.presentedViewController!
        //        }
        //        return topController

        var from = UIApplication.shared.keyWindow?.rootViewController
        while from != nil {
            if let to = (from as? UITabBarController)?.selectedViewController {
                from = to
            } else if let to = (from as? UINavigationController)?.visibleViewController {
                from = to
            } else if let to = from?.presentedViewController {
                from = to
            } else {
                break
            }
        }
        return from

    }
}
