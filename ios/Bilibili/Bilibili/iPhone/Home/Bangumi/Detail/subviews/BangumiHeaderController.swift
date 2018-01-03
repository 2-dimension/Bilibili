//
//  BangumiHeaderController.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/23.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import Kingfisher
import Sakura
import BilibiliAPI

class BangumiHeaderController: UIViewController
{
    
    @IBOutlet weak var titleBackgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var seasonsCollectionView: BangumiSeasonsCollectionView!
    @IBOutlet weak var episodesCollectionView: BangumiEpisodesCollectionView!
    @IBOutlet weak var tagsCollectionView: BangumiTagsView!
    @IBOutlet weak var recommendCollectionView: BangumiRelatedRecView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isFinishedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lastPlayLabel: UILabel!
    @IBOutlet weak var chooseEpisodeLabel: UILabel!
    @IBOutlet weak var updateInfoLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var lastPlayContainter: UIView!
    @IBOutlet weak var sponserViewContainer: UIView!
    
    @IBOutlet weak var lastPlayContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var sponserViewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var seasonsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var episodesCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tagsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendContainerHeight: NSLayoutConstraint!

    var sponserView: BangumiSponsorView = BangumiSponsorView.default()
    
    var bangumi: Bangumi? { didSet { _setBangumi() } }
    
    var onSeasonSelected: ((_: Season) -> Void)? = nil
    var onEpisodeSelected: ((_: Episode) -> Void)? = nil
    
    //MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sponserViewContainerHeight.constant = 0
        sponserViewContainer.addSubview(sponserView)
        sponserView.snp.makeConstraints { (make) in
            make.edges.equalTo(sponserViewContainer)
        }
        seasonsCollectionView.onCellSelected = {
            [unowned self](_ cell: BangumiSeasonsCollectionView.Cell) -> Void in
            self.onSeasonSelected?(cell.season!)
        }
        episodesCollectionView.onCellSelected = {
            [unowned self](_ cell: BangumiEpisodesCollectionViewCell) -> Void in
            self.onEpisodeSelected?(cell.episode!)
        }
        view.autoresizingMask = []
        view.height = view.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
    }
    
    
    private func _setBangumi() {
        if let bangumi = self.bangumi {
            //Infomation Label
            titleLabel.text = bangumi.title
            briefLabel.text = bangumi.brief
            statusLabel.text = ""
            isFinishedLabel.text = (bangumi.isFinish ?? false) ? R.string.localizable.bangumiFinished() : R.string.localizable.bangumiUnfinished("")
            
            //Last play
            let playHistory = bangumi.userSeason?.lastEpisodeIndex ?? 0
            lastPlayContainter.isHidden = playHistory == 0
            lastPlayContainerHeight.constant = (playHistory == 0) ? 0 : 32
            lastPlayLabel.text = R.string.localizable.bangumiEpisode(playHistory)
            
            //Image
            titleBackgroundImageView.kf.setImage(with: URL(string: bangumi.cover))
            coverImageView.kf.setImage(with: URL(string: bangumi.cover), placeholder: UIImage(color: .lightGray))
            
            //Subviews.
            seasonsCollectionView.seasons = bangumi.seasons
            seasonsCollectionView.currentSeason = bangumi.seasons?.first
            episodesCollectionView.episodes = bangumi.episodes?.reversed()
            episodesCollectionView.currentEpisode = bangumi.userSeason?.lastEpisodeIndex ?? 0
            recommendCollectionView.seasonID = bangumi.seasonID
            recommendContainerHeight.constant = 2 * ((UIScreen.main.bounds.width / 3 - 3) * 1.25 + 50) + 20
            
            //Bp
            if bangumi.allowBP ?? false {
                sponserViewContainer.isHidden = false
                sponserViewContainerHeight.constant = 136
                sponserView.setup(bangumi)
            } else {
                sponserViewContainer.isHidden = true
                sponserViewContainerHeight.constant = 0
            }
            
            //Tags
            tagsCollectionView.tags = bangumi.tags
            view.height = view.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
        }
    }
    
    // MARK: IBAction
    
    @IBAction func onClickBackButton(_ sender: Any) {
        view.superview?.viewController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickShareButton(_ sender: Any) {
        
    }
    
    @IBAction func onClickAttentionButton(_ sender: Any) {
        
    }
    
    @IBAction func onClickDownloadButton(_ sender: Any) {
        
    }
    
    @IBAction func onClickLastPlayButton(_ sender: Any) {
        
    }
    
    @IBAction func onClickMoreCommentButton(_ sender: Any) {
        
    }
}
