//
//  CommentCell.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/24.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import BilibiliAPI
import Sakura

class CommentCell: UITableViewCell
{
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var repliesImageView: UIImageView!
    @IBOutlet weak var likesImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var repliesLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var comment: Comment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.portraitImageView.omaskRadius = 18
        self.portraitImageView.omaskColor = UIColor(hex: 0xEEEEEEFF)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
    }
    
    func setup(_ comment: Comment?) {
        self.comment = comment
        
        if let comment = comment {
            usernameLabel.text = comment.member?.uname
            statusLabel.text = "#\(Int(comment.floor))"
            contentLabel.text = comment.content?.message
            repliesLabel.text = String((comment.rcount))
            likesLabel.text = String((comment.like))
            repliesImageView.isHidden = comment.rcount <= 0
            repliesLabel.isHidden = comment.rcount <= 0

            if let member = comment.member {
                portraitImageView.kf.setImage(with: URL(string: member.avatar))
                if member.levelInfo.currentLevel <= 9 && member.levelInfo.currentLevel >= 0 {
                    let imageName: String = "misc_level_whiteLv\(Int(member.levelInfo.currentLevel))"
                    levelImageView.image = UIImage(named: imageName)
                }

                switch member.sex {
                case "男": genderImageView.image = UIImage(named: "misc_sex_male")
                case "女": genderImageView.image = UIImage(named: "misc_sex_female")
                default: genderImageView.image = nil
                }
            }
        }
    }
    
    @IBAction func onLikeButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func onMoreButtonClick(_ sender: Any) {
        let actionSheet = UIActionSheet(title: "", delegate: nil, cancelButtonTitle: "", destructiveButtonTitle: "", otherButtonTitles: "")
        actionSheet.show(in: window!)
    }
}
