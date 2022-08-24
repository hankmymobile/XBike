//
//  AppDelegate.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyAczWQBWTCPKKN3SyXSxTMKIGVtjpcUxLA")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "loadedBoarding") {
            window?.rootViewController = UIStoryboard(name: "InitStoryboard", bundle: nil).instantiateInitialViewController()
        }else{
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
        window?.makeKeyAndVisible()
        changeColorStatus()
        
        return true
    }
    
    func loadInit(){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "loadedBoarding")
        window?.rootViewController = UIStoryboard(name: "InitStoryboard", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        changeColorStatus()
    }

    func changeColorStatus(){
        if #available(iOS 13, *) {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.1450980392, alpha: 1)
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
             // ADD THE STATUS BAR AND SET A CUSTOM COLOR
             let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
             if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.1450980392, alpha: 1)
             }
             UIApplication.shared.statusBarStyle = .lightContent
        }
    }
}

