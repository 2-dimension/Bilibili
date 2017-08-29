//
//  BangumiSeasonsCollectionViewCell.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/27.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import SnapKit
import Sakura
import BilibiliAPI

class BangumiSeasonsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate
{
    var seasons: [Season]? {
        didSet {
            DispatchQueue.main.async {
                [weak self] () -> Void in
                self?.reloadData()
            }
        }
    }
    var currentSeason: Season? //需要currentSeason中的season_id
    var onCellSelected: ((_ cell: Cell) -> Void)? = nil
    
    var flowLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    
    private let reuseIdentifier: String = "Cell"
    
    // MARK: Initialization
    private func initialize() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: 85, height: 40)
        self.dataSource = self
        self.delegate = self
        self.collectionViewLayout = flowLayout
        self.register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return seasons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
        if seasons != nil {
            let season = seasons?[indexPath.row]
            cell.setup(season)
            
            switch indexPath.row {
            case 0: cell.type = .left
            case seasons!.count - 1: cell.type = .right
            default: cell.type = .middle
            }
        }
        
        return cell
    }
    
    /* UICollectionViewDelegate */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if  let season = seasons?[indexPath.row],
            let currentSeasonID = currentSeason?.id {
            if season.id == currentSeasonID {
                DispatchQueue.main.async {
                    [weak self] () -> Void in
                    self?.selectItem(at: indexPath, animated: false, scrollPosition: [])
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.cellForItem(at: indexPath) as! Cell
        onCellSelected?(cell)
    }
    
    // MARK: Cell
    
    
    class Cell: UICollectionViewCell
    {
        var season: Season?
        var titleLabel: UILabel = UILabel()
        
        var type: CellType = .left {
            didSet {
                var imageView: UIImageView?
                var selectedImageView: UIImageView?
                switch type {
                case .left:
                    imageView = UIImageView(image: R.image.season_left())
                    selectedImageView = UIImageView(image: R.image.season_left_s())
                case .middle:
                    imageView = UIImageView(image: R.image.season_middle())
                    selectedImageView = UIImageView(image: R.image.season_middle_s())
                case .right:
                    imageView = UIImageView(image: R.image.season_right())
                    selectedImageView = UIImageView(image: R.image.season_right_s())
                }
                
                backgroundView = imageView
                selectedBackgroundView = selectedImageView
            }
        }
        
        override var isSelected: Bool {
            didSet {
                if isSelected {
                    titleLabel.textColor = UIColor(hex: 0xFFEA5B8D)
                } else {
                    titleLabel.textColor = UIColor(white: 0.5, alpha: 1)
                }
            }
        }
        
        //MARK: Initialization
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.initialize()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.initialize()
        }
        
        private func initialize() {
            titleLabel.textColor = UIColor(hex: 0xFF7F7F7F)
            titleLabel.font = UIFont.systemFont(ofSize: 13)
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.center.equalTo(self.contentView)
            }
        }
        
        //MARK: Methods
        
        func setup(_ season: Season?) {
            self.season = season
            titleLabel.text = season?.title
        }
        
        //MARK: Nested
        
        enum CellType : Int {
            case left
            case middle
            case right
        }
        
    }

}

