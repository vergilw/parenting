//
//  DCourseSectionViewController.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/10/26.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import UIKit
import AVFoundation

class DCourseSectionViewController: BaseViewController {

    lazy fileprivate var viewModel = CourseSectionViewModel()
    
    
    lazy fileprivate var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIConstants.Color.primaryGreen
        return view
    }()
    
    lazy fileprivate var dismissDimBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0.3)
        button.isHidden = true
        button.addTarget(self, action: #selector(courseSectionListAction), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var backgroundImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIConstants.Color.primaryGreen
        return imgView
    }()
    
    lazy fileprivate var cornerBgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.layer.cornerRadius = 5
        return imgView
    }()
    
    lazy fileprivate var backBarBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "public_backBarItem")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backBarItemAction), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var shareBarBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "public_shareBarItem")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
//        button.addTarget(self, action: #selector(<#BtnAction#>), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy fileprivate var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    lazy fileprivate var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "public_avatarPlaceholder")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 15
        imgView.isHidden = true
        return imgView
    }()
    
    lazy fileprivate var courseEntranceBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIConstants.Font.foot
        button.setTitle("进入课程", for: .normal)
        button.layer.cornerRadius = UIConstants.cornerRadius
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(courseEntranceBtnAction), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.body
        label.textColor = .white
        return label
    }()
    
    lazy fileprivate var tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.foot
        label.textColor = .white
        return label
    }()
    
    lazy fileprivate var audioPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIConstants.cornerRadius
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = UIConstants.cornerRadius
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        return view
    }()
    
    lazy fileprivate var audioActionBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIConstants.Color.primaryGreen
        button.setImage(UIImage(named: "course_playAction")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 22.5
        button.addTarget(self, action: #selector(audioActionBtnAction), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.foot
        label.textColor = UIConstants.Color.foot
        return label
    }()
    
    lazy fileprivate var audioSlider: UISlider = {
        let view = UISlider()
        view.minimumTrackTintColor = UIConstants.Color.primaryGreen
        view.maximumTrackTintColor = UIConstants.Color.background
        view.setThumbImage(UIImage(named: "course_audioSliderThumb"), for: .normal)
        view.addTarget(self, action: #selector(sliderTouchBeganAction), for: .touchDown)
        view.addTarget(self, action: #selector(sliderTouchEndedAction), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return view
    }()
    
    lazy fileprivate var audioCurrentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.foot
        label.textColor = UIConstants.Color.foot
        return label
    }()
    
    lazy fileprivate var audioDurationTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.foot
        label.textColor = UIConstants.Color.foot
        return label
    }()
    
    lazy fileprivate var playListBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIConstants.Color.primaryGreen, for: .normal)
        button.titleLabel?.font = UIConstants.Font.foot
        button.setTitle("播放列表", for: .normal)
        button.addTarget(self, action: #selector(courseSectionListAction), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var sectionTitleLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.font = UIConstants.Font.h1
        label.textColor = UIConstants.Color.head
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreenWidth-UIConstants.Margin.leading-UIConstants.Margin.trailing
        return label
    }()
    
    lazy fileprivate var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy fileprivate var lastOffsetY: CGFloat = 0
    
    lazy fileprivate var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    fileprivate var timeObserverToken: Any?
    
    lazy fileprivate var isSliderDragging: Bool = false
    
    lazy fileprivate var courseCataloguesView: CourseCataloguesView = {
        let view = CourseCataloguesView()
        view.dismissBlock = { [weak self] in
            self?.dismissDimBtn.sendActions(for: .touchUpInside)
        }
        view.selectedSectionBlock = { [weak self] sectionID in
            self?.reload(sectionID: sectionID)
        }
        return view
    }()
    
    init(courseID: Int, sectionID: Int) {
        super.init(nibName: nil, bundle: nil)
        viewModel.courseID = courseID
        viewModel.sectionID = sectionID
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initContentView()
        initConstraints()
        addNotificationObservers()
        
        viewModel.fetchCourseSection { (bool) in
            self.reload()
            self.courseCataloguesView.isBought = self.viewModel.courseSectionModel?.course?.is_bought
        }
        viewModel.fetchCourseSections { (bool) in
            self.courseCataloguesView.courseSectionModels = self.viewModel.courseCatalogueModels

            self.courseCataloguesView.tableView.reloadData()
            self.courseCataloguesView.tableView.layoutIfNeeded()
            
            if self.courseCataloguesView.tableView.contentSize.height < UIScreenHeight - self.courseCataloguesView.dismissArrowBtn.bounds.size.height {
                self.courseCataloguesView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.bottom.equalTo(self.view.snp.top)
                    if #available(iOS 11.0, *) {
                        make.height.equalTo(self.courseCataloguesView.tableView.contentSize.height + self.courseCataloguesView.dismissArrowBtn.bounds.size.height + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0))
                    } else {
                        make.height.equalTo(self.courseCataloguesView.tableView.contentSize.height + self.courseCataloguesView.dismissArrowBtn.bounds.size.height)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if scrollView.contentOffset.y > cornerBgImgView.frame.origin.y &&
            navigationView.frame.origin.y < -navigationView.frame.size.height + UIStatusBarHeight {
            return UIStatusBarStyle.default
        } else {
            return UIStatusBarStyle.lightContent
        }
    }
    
    // MARK: - ============= Initialize View =============
    func initContentView() {
        
        view.addSubviews([scrollView, navigationView, dismissDimBtn, courseCataloguesView])
        navigationView.addSubviews([backBarBtn, shareBarBtn, navigationTitleLabel])
        scrollView.addSubviews([backgroundImgView, cornerBgImgView, avatarImgView, courseEntranceBtn, titleLabel, tagLabel, audioPanelView, sectionTitleLabel, containerView])
        audioPanelView.addSubviews([audioActionBtn, progressLabel, audioSlider, audioCurrentTimeLabel, audioDurationTimeLabel, playListBtn])
        
        scrollView.layoutMargins = UIEdgeInsets(top: 16, left: 25, bottom: 16, right: 25)
        
    }
    
    // MARK: - ============= Constraints =============
    func initConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dismissDimBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImgView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(audioPanelView.snp.centerY).offset(10)
        }
        cornerBgImgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(audioPanelView.snp.centerY)
            make.height.equalTo(30)
        }
        navigationView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(navigationController!.navigationBar.bounds.size.height+UIStatusBarHeight)
        }
        courseCataloguesView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height)
        }
        backBarBtn.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.top.equalTo(UIStatusBarHeight)
            make.width.equalTo(62.5)
            make.height.equalTo(navigationController!.navigationBar.bounds.size.height)
        }
        shareBarBtn.snp.makeConstraints { make in
            make.trailing.equalTo(0)
            make.top.equalTo(UIStatusBarHeight)
            make.width.equalTo(69)
            make.height.equalTo(navigationController!.navigationBar.bounds.size.height)
        }
        navigationTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backBarBtn.snp.trailing)
            make.trailing.equalTo(shareBarBtn.snp.leading)
            make.top.equalTo(UIStatusBarHeight)
            make.bottom.equalToSuperview()
        }
        
        avatarImgView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp_leadingMargin)
            make.top.equalTo(navigationController!.navigationBar.bounds.size.height+UIStatusBarHeight+32)
            make.size.equalTo(UIConstants.Size.avatar)
        }
        courseEntranceBtn.snp.makeConstraints { make in
            make.trailing.equalTo(scrollView.snp_trailingMargin)
            make.centerY.equalTo(avatarImgView)
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp_leadingMargin)
            make.top.equalTo(avatarImgView.snp.top).offset(-2.5)
            make.trailing.greaterThanOrEqualTo(courseEntranceBtn.snp.leading).offset(-10)
            make.height.equalTo(14)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp_leadingMargin)
            make.trailing.greaterThanOrEqualTo(courseEntranceBtn.snp.leading).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(9)
            make.height.equalTo(12)
        }
        audioPanelView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp_leadingMargin)
            make.trailing.equalTo(scrollView.snp_trailingMargin)
            make.top.equalTo(avatarImgView.snp.bottom).offset(32)
            make.height.equalTo(94)
        }
        audioActionBtn.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(25)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        progressLabel.snp.makeConstraints { make in
            make.leading.equalTo(audioActionBtn.snp.trailing).offset(20)
            make.top.equalTo(audioActionBtn).offset(-5)
        }
        playListBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.centerY.equalTo(progressLabel)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        audioSlider.snp.makeConstraints { make in
            make.leading.equalTo(progressLabel)
            make.centerY.equalTo(audioActionBtn).offset(5)
            make.trailing.equalTo(-20)
        }
        audioCurrentTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(progressLabel)
            make.top.equalTo(audioSlider.snp.bottom).offset(4)
        }
        audioDurationTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(audioSlider)
            make.top.equalTo(audioSlider.snp.bottom).offset(4)
        }
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp_leadingMargin)
            make.trailing.equalTo(scrollView.snp_trailingMargin)
            make.top.equalTo(audioPanelView.snp.bottom).offset(32)
//            if #available(iOS 11.0, *) {
//                make.bottom.greaterThanOrEqualTo(scrollView.safeAreaLayoutGuide.snp.bottom).offset(-16)
//            } else {
//                make.bottom.equalTo(scrollView.snp.bottom).offset(-16)
//            }
        }
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp_leadingMargin)
            make.trailing.equalTo(scrollView.snp_trailingMargin)
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(32)
            make.bottom.equalTo(-32)
            make.width.equalTo(UIScreenWidth)
        }
    }
    
    // MARK: - ============= Notification =============
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTimeAction), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    // MARK: - ============= Request =============
    
    // MARK: - ============= Reload =============
    @objc func reload() {
        tableView.reloadData()
        
        if let audioURL = viewModel.courseSectionModel?.media_attribute?.service_url, player.currentItem == nil {
            if let playItem = URL(string: audioURL) {
                player = AVPlayer(url: playItem)
                timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main, using: { [weak self] (time) in
                    
                    guard let cmtime = self?.player.currentTime() else { return }
                    guard self?.player.rate != 0 else { return }
                    let seconds = CMTimeGetSeconds(cmtime)
                    guard seconds >= 0 else { return }
                    let timeInterval: TimeInterval = TimeInterval(seconds)
                    let date = Date(timeIntervalSince1970: timeInterval)
                    self?.audioCurrentTimeLabel.text = CourseCatalogueCell.timeFormatter.string(from: date)
                    
                    guard self?.isSliderDragging == false else { return }
                    guard let durationSeconds = self?.viewModel.courseSectionModel?.duration_with_seconds else { return }
                    self?.audioSlider.value = Float(seconds) / durationSeconds
                })
            }
        }
        
//        if let avatarURL = viewModel.courseSectionModel?.course?.teacher?.headshot_attribute?.service_url {
//            avatarImgView.kf.setImage(with: URL(string: avatarURL))
//        }
        
        titleLabel.text = viewModel.courseSectionModel?.title
        
        tagLabel.text = viewModel.courseSectionModel?.course?.teacher?.name ?? ""
        if let tags = viewModel.courseSectionModel?.course?.teacher?.tags {
            let tagString = tags.joined(separator: " | ")
            tagLabel.text = tagLabel.text?.appendingFormat(" | %@", tagString) 
        }
        
        progressLabel.text = String(format: "已学习%d%%", viewModel.courseSectionModel?.learned ?? 0)
        audioCurrentTimeLabel.text = "00:00"
        if let durationSeconds = viewModel.courseSectionModel?.duration_with_seconds {
            let duration: TimeInterval = TimeInterval(durationSeconds)
            let durationDate = Date(timeIntervalSince1970: duration)
            audioDurationTimeLabel.text = CourseCatalogueCell.timeFormatter.string(from: durationDate)
        }
        
        navigationTitleLabel.text = viewModel.courseSectionModel?.subtitle
        
        
        sectionTitleLabel.setParagraphText(viewModel.courseSectionModel?.subtitle ?? "")
        
        containerView.removeAllSubviews()
        var containerHeight: CGFloat = 0
        for imgAsset in viewModel.courseSectionModel?.content_images_attribute ?? [] {
            guard let height = imgAsset.height, let width = imgAsset.width else { continue }
            
            let imgView: UIImageView = {
                let imgView = UIImageView()
                imgView.kf.setImage(with: URL(string: imgAsset.service_url ?? ""))
                imgView.contentMode = .scaleToFill
                return imgView
            }()
            containerView.addSubview(imgView)
            
            let layoutHeight = CGFloat(height)/CGFloat(width)*(UIScreenWidth)
            imgView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(containerHeight)
                make.height.equalTo(layoutHeight)
            }
            containerHeight += layoutHeight
        }
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(32)
            make.bottom.equalTo(-32)
            make.width.equalTo(UIScreenWidth)
            make.height.equalTo(containerHeight)
        }
    }
    
    func reload(sectionID: Int) {
        viewModel.sectionID = sectionID
        
        viewModel.fetchCourseSection { (bool) in
            self.reload()
            self.courseCataloguesView.isBought = self.viewModel.courseSectionModel?.course?.is_bought
        }
    }
    
    // MARK: - ============= Action =============

    @objc func audioActionBtnAction() {
        guard let _ = viewModel.courseSectionModel?.media_attribute?.service_url else {
            return
        }
        if player.rate == 0  {
            player.play()
            audioActionBtn.setImage(UIImage(named: "course_pauseAction")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            player.pause()
            audioActionBtn.setImage(UIImage(named: "course_playAction")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @objc func sliderTouchBeganAction() {
        isSliderDragging = true
    }
    
    @objc func sliderTouchEndedAction() {
        guard let durationSeconds = viewModel.courseSectionModel?.duration_with_seconds, durationSeconds > 0 else {
            isSliderDragging = false
            return
        }
        player.seek(to: CMTime(seconds: Double(durationSeconds * audioSlider.value), preferredTimescale: CMTimeScale(NSEC_PER_SEC))) { (bool) in
            self.isSliderDragging = false
        }
    }
    
    @objc func playToEndTimeAction() {
        audioActionBtn.setImage(UIImage(named: "course_playAction")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc func courseEntranceBtnAction() {
        navigationController?.pushViewController(DCourseDetailViewController(), animated: true)
    }
    
    @objc func courseSectionListAction() {
        if courseCataloguesView.transform.isIdentity {
            
            self.dismissDimBtn.alpha = 0
            dismissDimBtn.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                self.courseCataloguesView.transform = CGAffineTransform(translationX: 0, y: self.courseCataloguesView.bounds.size.height)
                self.dismissDimBtn.alpha = 1
            })
            
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.courseCataloguesView.transform = CGAffineTransform.identity
                self.dismissDimBtn.alpha = 0
            }) { bool in
                self.dismissDimBtn.isHidden = true
            }
            
        }
        
    }
    
    deinit {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
    }
}

extension DCourseSectionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let offsetY = scrollView.panGestureRecognizer.vel
        
//        if offsetY < 0 {
//            if navigationView.frame.origin.y > 0 {
//                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
//                                              y: navigationView.frame.origin.y+offsetY,
//                                              width: navigationView.frame.size.width,
//                                              height: navigationView.frame.size.height)
//            } else {
//                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
//                                              y: -navigationView.frame.size.height,
//                                              width: navigationView.frame.size.width,
//                                              height: navigationView.frame.size.height)
//            }
//        } else {
//            if navigationView.frame.origin.y < 0 {
//                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
//                                              y: navigationView.frame.origin.y+offsetY,
//                                              width: navigationView.frame.size.width,
//                                              height: navigationView.frame.size.height)
//            } else {
//                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
//                                              y: 0,
//                                              width: navigationView.frame.size.width,
//                                              height: navigationView.frame.size.height)
//            }
//        }
        
        let offsetY = scrollView.contentOffset.y - lastOffsetY
        if scrollView.contentOffset.y < 0 {
            navigationView.frame = CGRect(x: navigationView.frame.origin.x,
                                          y: 0,
                                          width: navigationView.frame.size.width,
                                          height: navigationView.frame.size.height)
            lastOffsetY = 0
        } else if offsetY > 0 {
            if navigationView.frame.origin.y > -navigationView.frame.size.height &&
                offsetY < navigationView.frame.size.height {
                
                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
                                              y: (navigationView.frame.origin.y-offsetY < -navigationView.frame.size.height) ? -navigationView.frame.size.height : navigationView.frame.origin.y-offsetY,
                                              width: navigationView.frame.size.width,
                                              height: navigationView.frame.size.height)
            } else {
                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
                                              y: -navigationView.frame.size.height,
                                              width: navigationView.frame.size.width,
                                              height: navigationView.frame.size.height)
            }
            lastOffsetY = scrollView.contentOffset.y
        } else {
            if navigationView.frame.origin.y < 0 &&
                offsetY < navigationView.frame.size.height {
                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
                                              y: (navigationView.frame.origin.y-offsetY > 0) ? 0 : navigationView.frame.origin.y-offsetY,
                                              width: navigationView.frame.size.width,
                                              height: navigationView.frame.size.height)
            } else {
                navigationView.frame = CGRect(x: navigationView.frame.origin.x,
                                              y: 0,
                                              width: navigationView.frame.size.width,
                                              height: navigationView.frame.size.height)
            }
            lastOffsetY = scrollView.contentOffset.y
        }
        
        if scrollView.contentOffset.y > sectionTitleLabel.frame.origin.y+sectionTitleLabel.frame.size.height {
            navigationTitleLabel.isHidden = false
        } else {
            navigationTitleLabel.isHidden = true
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
}
