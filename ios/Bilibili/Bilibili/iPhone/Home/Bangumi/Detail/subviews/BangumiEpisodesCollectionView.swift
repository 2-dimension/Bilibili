//
//  BangumiEpisodesCollectionView.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/27.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import SnapKit
import Sakura
import BilibiliAPI

class BangumiEpisodesCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate
{
    var currentEpisode: Int = 0 //index of selected episode in array.
    var episodes: [Episode]? {
        didSet {
            DispatchQueue.main.async(execute: {
                [weak self] () -> Void in
                self?.reloadData()
            })
        }
    }
    var onCellSelected: ((_ cell: BangumiEpisodesCollectionViewCell) -> Void)? = nil
    
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private let reuseIdentifier: String = "Cell"
    
    // MARK: Initialization
    private func initialize() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: 160, height: 72)
        self.dataSource = self
        self.delegate = self
        collectionViewLayout = flowLayout
        self.register(R.nib.bangumiEpisodesCollectionViewCell(), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Override
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    // MARK: Delegate
    /* UICollectionViewDataSource */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BangumiEpisodesCollectionViewCell
        if let episode = episodes?[indexPath.row] {
            cell.setup(episode)
        }
        return cell
    }
    
    /* UICollectionViewDelegate */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == currentEpisode {
            DispatchQueue.main.async(execute: {
                [weak self] () -> Void in
                self?.selectItem(at: indexPath, animated: false, scrollPosition: [])
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: BangumiEpisodesCollectionViewCell = self.cellForItem(at: indexPath) as! BangumiEpisodesCollectionViewCell
        onCellSelected?(cell)
    }
    
    // MARK: Getter & Setter
}


class BangumiEpisodesCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var episode: Episode?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor(hex: 0xFFEA5B8D).cgColor //RGB(234, 91, 141).cgColor
                titleLabel?.textColor = UIColor(hex: 0xFFEA5B8D)
                episodeLabel.textColor = UIColor(hex: 0xFFEA5B8D)//RGB(234, 91, 141)
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
                titleLabel?.textColor = UIColor.black
                episodeLabel.textColor = UIColor.black
            }
        }
    }
    
    func setup(_ episode: Episode) {
        self.episode = episode
        episodeLabel.text = R.string.localizable.bangumiEpisode(episode.index)
        titleLabel.text = episode.indexTitle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if episode == nil {
            return
        }
//        let controller = VideoViewController(aid: episode.av_id, episodeID: episode.episode_id)
//        navigationController?.pushViewController(controller as? UIViewController ?? UIViewController(), animated: true)
    }
}
