//
//  BangumiRelatedRecView.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/28.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import Kingfisher
import Sakura
import BilibiliAPI

class BangumiRelatedRecView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate
{
    var seasonID: Int = 0 {
        didSet {
            loadRelativeBangumis()
        }
    }
    
    var bangumis: [Bangumi]?
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private let PADDING: CGFloat = 30.0
    
    private let reuseIdentifier: String = "Cell"
    
    // MARK: Initialization
    private func initialize() {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - ceil(2.0 * PADDING / 3),
                                     height: (UIScreen.main.bounds.width / 3 - ceil(2.0 * PADDING / 3)) * 1.25 + 50)
        self.dataSource = self
        self.delegate = self
        self.collectionViewLayout = flowLayout
        contentInset = UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING)
        register(R.nib.bangumiRelatedRecViewCell(), forCellWithReuseIdentifier: reuseIdentifier)
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
        return bangumis?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BangumiRelatedRecViewCell
        if let bangumi: Bangumi = bangumis?[indexPath.row] {
            cell.setup(bangumi)
            cell.episodeLabel?.isHidden = true
            cell.viewersLabel?.text = R.string.localizable.homeBangumiFollowers(bangumi.favorites ?? "")
        }
        return cell
    }
    
    // MARK: Getter & Setter
    
    // MARK: Encapsulation
    func loadRelativeBangumis() {

        BilibiliAPI.getBangumiRecommendation(sid: seasonID, success: { (response) in
            self.bangumis = response.result
            DispatchQueue.main.async {
                [weak self] () -> Void in
                self?.reloadData()
            }
        }, failure: { (response) in
            
        })
    }
    
    
    
}


class BangumiRelatedRecViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var viewersLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    private let gradientLayer = CAGradientLayer()
    
    var bangumi: Bangumi?
    
    func setup(_ bangumi: Bangumi) {
        self.bangumi = bangumi
        titleLabel?.text = bangumi.title
        episodeLabel.text = R.string.localizable.homeBangumiCurrentEpisode(bangumi.newestEpisodeIndex ?? 0)
        coverImageView.kf.setImage(with: URL(string: bangumi.cover), placeholder: UIImage(color: UIColor.lightGray))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        //            titleLabel.verticalAlignment = VerticalAlignmentTop
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(hex: 0x00000066).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        coverImageView.layer.addSublayer(gradientLayer)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bangumi == nil { return }
        
        let controller = BangumiViewController(bangumi: bangumi!)
        //    [self.viewController.navigationController pushViewController:controller animated:YES];
        navigationController?.pushViewController(controller, animated: true)
    }
}
