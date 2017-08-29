//
//  CommentViewController.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/23.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import MJRefresh
import Sakura
import BilibiliAPI

class CommentViewController: LoadingViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate
{
    var aid: Int = 0 { didSet { loadComments() } }
    
    var page: Int = 0
    var tableView: UITableView?
    
    var comments: Comments?
    
    // MARK: Initialization
    
    init(aid: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.aid = aid
        self.page = 1
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (navigationController != nil) {
            navigationController?.delegate = self
        }
        
        //Tableview.
        tableView = UITableView(frame: view!.bounds, style: .grouped)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor(white: 0.95, alpha: 1.000)
        tableView?.contentInset = UIEdgeInsetsMake(0, 0, -44, 0)
        tableView?.estimatedRowHeight = 200
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            [weak self] () -> Void in
            self?.loadComments()
        })
        view?.addSubview(tableView!)
        
        let footer: MJRefreshAutoFooter? = (tableView?.mj_footer as? MJRefreshAutoFooter)
        footer?.triggerAutomaticallyRefreshPercent = -2.5
        tableView?.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "Cell")
        loadComments()
    }
    
    // MARK: Delegate
    /* UINavigationControllerDelegate */
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //隐藏导航栏
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    /* TableViewDataSource */
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments?.hots.count == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int? = 0
        
        if comments?.hots.count == 0 {
            count = comments?.replies.count
        }
        
        switch section {
        case 0: count = comments?.hots.count
        case 1: count = comments?.replies.count
        default: count = 0
        }
        
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentCell
        var comment: Comment?
        
        if comments?.hots.count == 0 { //无热评
            comment = comments?.replies[indexPath.row]
        } else {
            switch indexPath.section {
            case 0: comment = comments?.hots[indexPath.row]
            default: comment = comments?.replies[indexPath.row]
            }
        }
        
        cell.setup(comment)
        
        return cell
    }
    
    /* TableViewDelegate */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (self.tableView?.width)!, height: 30))
        view.autoresizingMask = .flexibleWidth
        
        var button = UIButton(type: .custom)
        button.size = CGSize(width: 120, height: 30)
        button.centerX = view.centerX
        button.backgroundColor = self.tableView?.backgroundColor
        button.setTitle(R.string.localizable.commentMoreHotComments(), for: .normal)
        button.setTitleColor(UIColor(red: 1.000, green: 0.441, blue: 0.671, alpha: 1.000), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(onClickMoreHotCommentsButton), for: .touchUpInside)
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 0.5))
        separator.backgroundColor = .lightGray
        separator.centerY = view.centerY
        
        view.addSubview(separator)
        view.addSubview(button)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1: return 30
        default: return 0.1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    // MARK: Encapsulation
    func loadComments() {
        if aid == 0 { return }
        
        BilibiliAPI.getComments(aid: aid, page: page, success: { (response) in
            if self.comments == nil || self.page == 0 {
                self.comments = response.result
            } else {
                self.comments?.replies += response.result?.replies ?? []
            }
            
            self.page += 1
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
            if (response.result?.replies.count ?? 0) != 0 {
                self.tableView?.mj_footer?.endRefreshing()
            } else {
                self.tableView?.mj_footer?.endRefreshingWithNoMoreData()
            }
        }, failure: { (response) in
            self.tableView?.mj_footer?.endRefreshing()
        })
    }
    
    // MARK: Callback
    @objc func onClickMoreHotCommentsButton(_ sender: UIButton) {
        
    }
    
}
