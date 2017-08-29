//
//  HomeViewController.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/6/24.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import React
import SnapKit
import Sakura

class HomeViewController: UIViewController
{
    static var route: String = "tsetest"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(onButtonClick(button:)), for: .touchUpInside)
        button.extraHitInsets = UIEdgeInsets(top: 500, left: 500, bottom: 500, right: 500)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }

        // Do any additional setup after loading the view.
    }
    
    
    //Callback
    
    @objc func onButtonClick(button: UIButton) {
//        showReactView()
        showCommentsView()
    }
    
    func showReactView() {
        let jsCodeLocation = URL(string: Strings.REACT_NATIVE_URL)
        let mockData:NSDictionary = ["scores": [
            ["name":"Alex", "value":"42"],
            ["name":"Joel", "value":"10"]
            ]
        ]
        
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "Bilibili",
            initialProperties: mockData as [NSObject : AnyObject],
            launchOptions: nil
        )
        let vc = UIViewController()
        vc.view = rootView
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showCommentsView() {
//        let controller = CommentViewController(aid: 13599724)
        let controller = BangumiViewController(seasonID: 1539)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
