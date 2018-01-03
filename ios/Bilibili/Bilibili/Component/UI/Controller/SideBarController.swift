//
//  SideBarController.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/9/30.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import ObjectiveC
import Sakura

class SideBarController: UIViewController, UITabBarControllerDelegate
{
    var embededController: UITabBarController?
    var sideBar: SideBar! = SideBar()
    
    weak var delegate: SideBarControllerDelegate?
    
//    @IBInspectable var viewControllers: [UIViewController] = []
    
    //MARK: Override
    
    override func loadView() {
        super.loadView()
        (NSClassFromString("UITabBarSwappableImageView")! as! NSObject.Type).printIvars()
        sideBar = SideBar(frame: CGRect(x: 0, y: 0, width: 64, height: UIScreen.main.bounds.height))
        sideBar.backgroundColor = .orange
        self.view.addSubview(sideBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if embededController == nil {
            let embededController = UITabBarController()
            embededController.delegate = self
            embededController.view.frame = self.view.bounds.insetBy(dx: 64, dy: 0).offsetBy(dx: 32, dy: 0)
            embededController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(embededController.view)
            self.embededController = embededController
        }
    
        handleTabBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        embededController?.tabBar.removeFromSuperview()
        
        print(self.sideBar.barButtons.first?.imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.sideBar.barButtons.first?.imageView.image = nil
//        self.sideBar.barButtons.first?.imageView.image = self.sideBar.barButtons.first?.imageView.value(forKey: "_alternate") as? UIImage
//        self.sideBar.barButtons.first?.imageView.setValue(true, forKey: "_showAlternate")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleTabBarButtons()
        embededController?.view.frame = CGRect(x: sideBar.width, y: 0, width: self.view.width - 64, height: self.view.height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embed" {
            if let controller = segue.destination as? UITabBarController {
                embededController = controller
                embededController?.view.clearConstraints()
            }
        }
    }
    
    // MARK: Encapsulation
    
    func handleTabBarButtons() {
        
        if let tabBar = embededController?.tabBar {
            
            // Get all tab bar buttons.
            var tabBarButtons = [UIView]()
            for subview in tabBar.subviews {
                if subview.isKind(of: NSClassFromString("UITabBarButton")!) {
                    tabBarButtons.append(subview)
                }
            }
            
            // handle.
            for i in 0..<tabBarButtons.count {
                let tabBarButton = tabBarButtons[i]
                let origin = CGPoint(x: 0, y: 100 + sideBar.width * i.f)
                let size = CGSize(width: sideBar.width, height: sideBar.width)
                tabBarButton.removeFromSuperview()
                tabBarButton.isUserInteractionEnabled = false
                let wrapper = UITabBarButtonSh(tabBarButton: tabBarButton as! UIControl)
                wrapper.frame = CGRect(origin: origin, size: size)
                sideBar.add(wrapper)
            }
            
        }
        
    }
    
    
    // MARK: Delegate
    
    /* UITabBarControllerDelegate */
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool  {
        return true
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)  {
//        for controller in self.viewControllers ?? [] {
//            controller.view.frame = CGRect(x: tabBar.width, y: 0, width: UIScreen.main.bounds.width - 64, height: UIScreen.main.bounds.height)
//        }
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController])  {
        
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        
    }
    
    public func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        return .all
    }
    
    public func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController) -> UIInterfaceOrientation {
        return .portrait
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    //MARK: Methods
    
    func addTab(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
    
    
    
    class SideBar: UIRadio
    {
        
        var barButtons = [UITabBarButtonSh]()
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        
        func add(_ barButton: UITabBarButtonSh)  {
            if barButton.superview == nil {
                self.addSubview(barButton)
                self.barButtons.append(barButton)
            }
        }
        
    }
    
    class SideBarButton: UIView {
        
    }
    
}

@objc protocol SideBarControllerDelegate {
    
}

class UITabBarButtonSh: UIView {
    
    var tabBarButton: UIControl!
    
    var imageView: UIImageView {
        return tabBarButton.value(forKey: "_info") as! UIImageView
    }
    
    var imageEdgeInset: UIEdgeInsets {
        return tabBarButton.value(forKey: "_infoInsets") as! UIEdgeInsets
    }
    
    var label: UILabel {
        return tabBarButton.value(forKey: "_label") as! UILabel
    }
    
    var image: UIImage? {
        return imageView.value(forKey: "_value") as? UIImage
    }
    
    var highlightedImage: UIImage? {
        return imageView.value(forKey: "_alternate") as? UIImage
    }
    
    //MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    init(tabBarButton: UIControl) {
        super.init(frame: .zero)
        self.tabBarButton = tabBarButton
        self.tabBarButton.frame = self.bounds
        self.tabBarButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(tabBarButton)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        if tabBarButton == nil {
            let UITabBarButton = NSClassFromString("UITabBarButton") as! NSObject.Type
            let object = class_createInstance(UITabBarButton, 0) as! UIControl
            tabBarButton = object
        }
    }

}

