//
//  BangumiTagsView.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/28.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import Sakura
import BilibiliAPI

class BangumiTagsView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var tags: [Tag]?
    
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private let reuseIdentifier: String = "Cell"
    
    // MARK: Initialization
    private func initialize() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 0
        self.dataSource = self
        self.delegate = self
        collectionViewLayout = flowLayout
        register(BangumiTagsViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BangumiTagsViewCell
        if let tag = tags?[indexPath.row] {
            cell.setup(tag)
        }
        return cell
    }
    
    /* UICollectionViewDelegate */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = BangumiTagsViewCell(frame: .zero)
        cell.label.text = tags?[indexPath.row].name
        cell.label.sizeToFit()
        return CGSize(width: cell.label.size.width + 20, height: 28)
    }
    
    // MARK: Getter & Setter
    func setTags(_ tags: [Tag]) {
        self.tags = tags
        reloadData()
    }
}

class BangumiTagsViewCell: UICollectionViewCell
{
    var bangumiTag: Tag?
    var label: UILabel = UILabel(frame: .zero)
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initialize() {
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        label.frame = self.bounds
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        self.addSubview(label)
    }
    
    //MARK: Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.centerX = width * 0.5
        label.centerY = height * 0.5
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow != nil {
            self.layer.cornerRadius = height * 0.5
        }
    }
    
    // MARK: - Public
    
    func setup(_ tag: Tag) {
        self.bangumiTag = tag
        label.text = tag.name
    }
    
}

