//
//  BangumiViewController.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/23.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import Sakura
import MJRefresh
import URLNavigator
import BilibiliAPI

class BangumiViewController: CommentViewController
{
    var sid: Int = 0
    var bangumi: Bangumi?
    var headerController: BangumiHeaderController?
    var statusBarStyle: UIStatusBarStyle = .default

    lazy var navigationBar: UIView = {
        let height: CGFloat = 64
        
        let navigationBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        navigationBar.backgroundColor = UIColor.white
        navigationBar.alpha = 0
        
        let label = UILabel()
        label.text = R.string.localizable.bangumiTitle()
        label.textColor = UIColor.darkGray
        label.sizeToFit()
        label.centerX = navigationBar.width * 0.5
        label.centerY = navigationBar.height * 0.5 + 10
        navigationBar.addSubview(label)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: -12, y: 20, width: height, height: height - 20)
        button.tintColor = UIColor.darkGray
        button.setImage(R.image.common_back_v2(), for: .normal)
        button.addTarget(self, action: #selector(onClickBackItem), for: .touchUpInside)
        navigationBar.addSubview(button)
        return navigationBar
    }()

    // MARK: Initialization

    init(bangumi: Bangumi) {
        super.init(aid: bangumi.episodes?.first?.aid ?? 0)

        self.bangumi = bangumi
        sid = bangumi.seasonID

    }

    init(seasonID sid: Int) {
        super.init(nibName: nil, bundle: nil)

        self.sid = sid
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init
        self.statusBarStyle = .lightContent
        
        //Navigatior
        view.addSubview(navigationBar)
        
        //Header
        headerController = BangumiHeaderController()
        headerController?.view?.backgroundColor = UIColor(white: 0.95, alpha: 1.000)
        tableView?.tableHeaderView = headerController?.view

        headerController?.onSeasonSelected = {
            [unowned self] (_ season: Season) -> Void in
            self.page = 0
            self.loadBangumi(season.id)
        }
        headerController?.onEpisodeSelected = {(_ episode: Episode) -> Void in
            self.page = 0
            self.aid = episode.aid
        }
        
        //API.
        loadBangumi(sid)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    // MARK: Delegate
    /* ScrollView Delegate */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        //禁止顶部bounce
        if offset < 0 {
            tableView?.contentOffset = CGPoint.zero
        }
        
        //更新StatusBar
        let previousStyle: UIStatusBarStyle = statusBarStyle
        if offset > 40 {
            statusBarStyle = .default
        } else {
            statusBarStyle = .lightContent
        }
        if previousStyle != statusBarStyle {
            setNeedsStatusBarAppearanceUpdate()
        }
        //更新navigationBar透明度
        self.navigationBar.alpha = offset / 50
    }

    // MARK: Encapsulation
    func loadBangumi(_ sid: Int) {

        BilibiliAPI.getBangumiInfo(sid: sid, success: { (response) -> Void in
            if let bangumi = response.result {
                self.bangumi = bangumi
                self.aid = bangumi.episodes?.first?.aid ?? 0
                self.refreshUI()
            }
        }, failure: { (response) -> Void in

        })
    }

    func refreshUI() {
        headerController?.bangumi = bangumi
        tableView?.tableHeaderView = headerController?.view
        if  let userSeason = self.bangumi?.userSeason,
            let episodes = self.bangumi?.episodes {
            if userSeason.lastEpisodeIndex < episodes.count {
                aid = episodes[userSeason.lastEpisodeIndex].aid
            }
        }

    }

    // MARK: Callback
    @objc func onClickBackItem(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

