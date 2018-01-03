//
//  Navigator.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/11/2.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import URLNavigator
import Sakura

extension Navigator
{
    
    static var `default`: Navigator = {
        let navigator = Navigator()
        
        //bili://video?id=12450
        //bili://video/12450
        navigator.register("bili://video") {
            (url, values, context) -> UIViewController? in
            if  let id = url.queryParameters["id"]?.int {
                let page = url.queryParameters["page"]?.int ?? 1
                let controller = UIViewController()
                return controller
            }
            return nil
        }
        navigator.register("bili://video/<int:id>", {
            (url, values, context) -> UIViewController? in
            if  let id = values["id"] as? Int {
                let controller = UIViewController()
                return controller
            }
            return nil
        })
        
        //bili://live?id=12450
        //bili://live/12450
        navigator.register("bili://live") {
            (url, values, context) -> UIViewController? in
            if  let id = url.queryParameters["id"]?.int {
                let controller = UIViewController()
                return controller
            }
            return nil
        }
        navigator.register("bili://live/<int:id>", {
            (url, values, context) -> UIViewController? in
            if  let id = values["id"] as? Int {
                let controller = UIViewController()
                return controller
            }
            return nil
        })
        
        //bili://bangumi?id=12450
        //bili://bangumi/12450
        navigator.register("bili://bangumi") {
            (url, values, context) -> UIViewController? in
            if  let id = url.queryParameters["id"]?.int {
                let controller = UIViewController()
                return controller
            }
            return nil
        }
        navigator.register("bili://bangumi/<int:id>", {
            (url, values, context) -> UIViewController? in
            if  let id = values["id"] as? Int {
                let controller = UIViewController()
                return controller
            }
            return nil
        })
        
        return navigator
    }()
    
    
    static var hd: Navigator = {
        let navigator = Navigator()
        
        //bili://video?id=12450
        //bili://video/12450
        navigator.register("bili://video") {
            (url, values, context) -> UIViewController? in
            if  let id = url.queryParameters["id"]?.int {
                let page = url.queryParameters["page"]?.int ?? 1
                let controller = UIViewController()
                return controller
            }
            return nil
        }
        navigator.register("bili://video/<int:id>", {
            (url, values, context) -> UIViewController? in
            if  let id = values["id"] as? Int {
                let controller = UIViewController()
                return controller
            }
            return nil
        })
        
        //bili://live?id=12450
        //bili://live/12450
        navigator.register("bili://live") {
            (url, values, context) -> UIViewController? in
            if  let id = url.queryParameters["id"]?.int {
                let controller = UIViewController()
                return controller
            }
            return nil
        }
        navigator.register("bili://live/<int:id>", {
            (url, values, context) -> UIViewController? in
            if  let id = values["id"] as? Int {
                let controller = UIViewController()
                return controller
            }
            return nil
        })
        
        //bili://bangumi?id=12450
        //bili://bangumi/12450
        navigator.register("bili://bangumi") {
            (url, values, context) -> UIViewController? in
            if  let id = url.queryParameters["id"]?.int {
                let controller = UIViewController()
                return controller
            }
            return nil
        }
        navigator.register("bili://bangumi/<int:id>", {
            (url, values, context) -> UIViewController? in
            if  let id = values["id"] as? Int {
                let controller = UIViewController()
                return controller
            }
            return nil
        })
        
        return navigator
    }()
    
}

