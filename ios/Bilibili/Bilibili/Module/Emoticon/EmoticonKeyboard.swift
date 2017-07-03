//
//  EmoticonKeyboard.swift
//  bukaios
//
//  Created by YaeSakura on 2017/5/10.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//
//
//import Foundation
//import YYKit
//
//class EmoticonKeyborad: UIView, UICollectionViewDataSource, UICollectionViewDelegate
//{
//    // MARK: - Properties
//    
//    var collectionView : UICollectionView!
//    var toolbar = ToolBar()
//    
//    var currentIndex : Int = 0
//    
//    var emoticonDidClicked : ((Emoticon, NSIndexPath) -> Void)? = nil
//    
//    //    var textView : UITextView? = nil {       //Use this parameter to bind a text view & emoticon input view
//    //        didSet {
//    //            textView?.inputView = self
//    //        }
//    //    }
//    
//    private var emoticonGroups = [EmoticonGroup]()
//    
//    private var totolPageCount: Int = 0
//    private var groupPageIndexs = [Int]()
//    private var emoticonCounts = [Int]()
//    
//    // MARK: - Constants
//    
//    static let FRAME  = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 216)
//    
//    static let EMOTICON_PER_PAGE = 20
//    static let EMOTICON_PER_LINE = 7
//    static let EMOTICON_SECTION_PADDING : CGFloat = 10
//    
//    static let TOOLBAR_HEIGHT : CGFloat = 36
//    
//    // MARK: - Intitialization
//    
//    init() {
//        super.init(frame: EmoticonInputView.FRAME)
//        
//        self.backgroundColor = UIColor.whiteColor
//        
//        setupGroups()
//        setupTopLine()
//        setupCollectionView()
//        setupToolbar()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//    }
//    
//    private func setupGroups()
//    {
//        emoticonGroups = EmoticonManager.emoticonGroups
//        
//        groupPageIndexs.append(0)
//        emoticonCounts.append(0)
//        for i in 0 ..< emoticonGroups.count
//        {
//            var count = Int(ceil(emoticonGroups[i].emoticons.count.. / EmoticonInputView.EMOTICON_PER_PAGE..))
//            if count == 0 { count = 1 }
//            totolPageCount += count
//            //            if i == 0
//            //            {
//            //                groupPageIndexs.append(count)
//            //                emoticonCounts.append(emoticonGroups[i].emoticons.count)
//            //            }
//            //            else
//            //            {
//            //                groupPageIndexs.append(count + groupPageIndexs[i - 1])
//            //                emoticonCounts.append(emoticonGroups[i].emoticons.count + emoticonCounts[i - 1])
//            //            }
//            groupPageIndexs.append(count + groupPageIndexs[i])
//            emoticonCounts.append(emoticonGroups[i].emoticons.count + emoticonCounts[i])
//        }
//        //        print(emoticonCounts)
//        //        print(groupPageIndexs)
//    }
//    
//    private func setupTopLine()
//    {
//        let topline = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: ONE_PIXEL))
//        topline.backgroundColor = UIColor.grayColor()
//        topline.autoresizingMask = .FlexibleWidth
//        self.addSubview(topline)
//    }
//    
//    private func setupCollectionView()
//    {
//        //Layout preset.
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: (self.width - EmoticonInputView.EMOTICON_SECTION_PADDING * 2) / CGFloat(EmoticonInputView.EMOTICON_PER_LINE), height: 50)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: EmoticonInputView.EMOTICON_SECTION_PADDING, bottom: 0, right: EmoticonInputView.EMOTICON_SECTION_PADDING)
//        
//        //CollectionView
//        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.width, height: layout.itemSize.height * 3), collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.top = 5
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.backgroundColor = UIColor.clearColor()
//        collectionView.backgroundView = UIView()
//        collectionView.registerClass(EmoticonCell.self, forCellWithReuseIdentifier: "Cell")
//        self.addSubview(collectionView)
//        
//        //Page Control
//        let pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView.height + 5, width: collectionView.width, height: 20))
//        self.addSubview(pageControl)
//    }
//    
//    private func setupToolbar()
//    {
//        //Setup toolbar
//        self.addSubview(toolbar)
//        toolbar.size = CGSize(width: self.width, height: EmoticonInputView.TOOLBAR_HEIGHT)
//        toolbar.bottom = self.height
//        
//        //Setup toolbar buttons
//        for i in 0 ..< emoticonGroups.count
//        {
//            let button = UIButton(type: .System)
//            button.tag = i
//            button.size = CGSize(width: self.width / CGFloat(emoticonGroups.count), height: EmoticonInputView.TOOLBAR_HEIGHT)
//            button.frame.origin.x = button.width * CGFloat(i)
//            button.titleLabel?.font = UIFont.systemFontOfSize(14)
//            button.exclusiveTouch = true
//            button.setTitle(emoticonGroups[i].group_name_cn, forState: .Normal)
//            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
//            button.setBackgroundImage(UIImage(color: UIColor(white: 0, alpha: 0.5)), forState: .Highlighted)
//            button.addTarget(self, action: "toolbarButtonDidClicked:", forControlEvents: .TouchUpInside)
//            toolbar.buttons.append(button)
//            toolbar.addSubview(button)
//        }
//        toolbar.buttons.first?.selected = true
//    }
//    
//    // MARK: - Delegate
//    
//    //UIScrollViewDelegate
//    func scrollViewDidScroll(scrollView: UIScrollView)
//    {
//        var page : Int = Int(round(scrollView.contentOffset.x / scrollView.width))
//        if page < 0 { page = 0 }
//        else if page > totolPageCount { page = totolPageCount - 1 }
//        if page == currentIndex { return }
//        currentIndex = page
//        
//        //Set toolbar button selected
//        for button in toolbar.buttons
//        {
//            button.selected = false
//        }
//        for i in 0 ..< groupPageIndexs.count
//        {
//            if currentIndex < groupPageIndexs[i + 1]
//            {
//                toolbar.buttons[i].selected = true
//                break
//            }
//        }
//    }
//    
//    //UICollectionViewDataSource
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//    {
//        return totolPageCount
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        return EmoticonInputView.EMOTICON_PER_PAGE + 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell
//    {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EmoticonCell
//        
//        if indexPath.row == EmoticonInputView.EMOTICON_PER_PAGE
//        {
//            cell.imageView.image = UIImage(named: "compose_emotion_delete")
//            cell.label.text = ""
//            return cell
//        }
//        
//        let emoticon = emoticonAtIndexPath(indexPath)
//        cell.setup(emoticon)
//        
//        return cell
//    }
//    
//    //UICollectionViewDelegate
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let emoticon = emoticonAtIndexPath(indexPath)
//        emoticonDidClicked?(emoticon, indexPath)
//    }
//    
//    // MARK: - Emcapsulation
//    
//    private func emoticonAtIndexPath(indexPath : NSIndexPath) -> Emoticon
//    {
//        var emoticon = Emoticon()
//        for i in 0 ..< groupPageIndexs.count
//        {
//            let page = indexPath.section
//            if page < groupPageIndexs[i + 1]
//            {
//                let pageInGroup = indexPath.section - groupPageIndexs[i]
//                let index = pageInGroup * (EmoticonInputView.EMOTICON_PER_PAGE) + indexPath.row
//                
//                let indexInPage = index % EmoticonInputView.EMOTICON_PER_PAGE
//                let transpose = (indexInPage % 3) * 7 + indexInPage / 3
//                let reindex = transpose + pageInGroup * EmoticonInputView.EMOTICON_PER_PAGE
//                
//                if reindex < emoticonGroups[i].emoticons.count
//                {
//                    emoticon = emoticonGroups[i].emoticons[reindex]
//                }
//                break
//            }
//        }
//        
//        return emoticon
//    }
//    
//    // MARK: - Call-back function
//    
//    @objc func toolbarButtonDidClicked(sender : UIButton)
//    {
//        //Scroll to the specific group
//        let point = CGPoint(x: CGFloat(groupPageIndexs[sender.tag]) * self.width, y: 0)
//        collectionView.setContentOffset(point, animated: true)
//    }
//    
//    // MARK: - Inner Classes
//    
//    class ToolBar : UIScrollView
//    {
//        var buttons = [UIButton]()
//    }
//}
