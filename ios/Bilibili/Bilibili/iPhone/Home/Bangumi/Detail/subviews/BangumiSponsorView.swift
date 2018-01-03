//
//  BangumiSponsorView.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/25.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import Kingfisher
import BilibiliAPI

class BangumiSponsorView: UIView
{
    @IBOutlet weak var sponsersLabel: UILabel!
    @IBOutlet weak var sponsersWeeklyLabel: UILabel!
    @IBOutlet weak var sponser1: UIImageView!
    @IBOutlet weak var sponser2: UIImageView!
    @IBOutlet weak var sponser3: UIImageView!
    @IBOutlet weak var sponser4: UIImageView!
    
    var bangumi: Bangumi?
    
    class func `default`() -> BangumiSponsorView {
        return R.nib.bangumiSponsorView.instantiate(withOwner: nil).first as! BangumiSponsorView
        //Bundle.main.loadNibNamed("BangumiSponsorView", owner: nil, options: nil)?.first! as! BangumiSponsorView
    }
    
    func setup(_ bangumi: Bangumi) {
        self.bangumi = bangumi
        
        if let rank = bangumi.rank {
            
            //Sponsers.
            if rank.totalBpCount != 0 {
                sponsersLabel.text = R.string.localizable.bangumiSponsors(rank.totalBpCount)
            } else {
                sponsersLabel.text = R.string.localizable.bangumiNoSponsors()
            }
            
            if rank.weekBpCount != 0 {
                sponsersWeeklyLabel.text = R.string.localizable.bangumiSponsorsWeekly(rank.weekBpCount)
            } else {
                sponsersWeeklyLabel.text = R.string.localizable.bangumiNoSponsorsWeekly()
            }
            
            //Avatars of sponsers.
            let views: [UIImageView] = [sponser1, sponser2, sponser3, sponser4]
            for i in 0..<min(views.count - 1, rank.list.count - 1) {
                views[i].kf.setImage(with: URL(string: rank.list[i].face))
            }
        }

    }
}
