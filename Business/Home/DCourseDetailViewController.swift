//
//  DCourseDetailViewController.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/10/24.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import UIKit
import Kingfisher

class DCourseDetailViewController: BaseViewController {

    /*
    private let kBannerHeight: CGFloat = 400.0
    
    private var lastContentOffsetY: CGFloat = 0.0
    
    lazy fileprivate var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.backgroundColor = .gray
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    lazy fileprivate var categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .green
        return scrollView
    }()
    
    lazy fileprivate var bannerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .orange
        return view
    }()
    
    lazy fileprivate var introductionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.backgroundColor = .red
//        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        return scrollView
    }()
    
    lazy fileprivate var catalogueTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CourseCatalogueCell.self, forCellReuseIdentifier: CourseCatalogueCell.className())
        tableView.separatorStyle = .none
        tableView.rowHeight = 105 //UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        let header = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreenWidth, height: kBannerHeight)))
        tableView.tableHeaderView = header
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
        }
        tableView.backgroundColor = .yellow
        tableView.alwaysBounceVertical = true
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        return tableView
    }()
    
    lazy fileprivate var evaluationTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CourseCatalogueCell.self, forCellReuseIdentifier: CourseCatalogueCell.className())
        tableView.separatorStyle = .none
        tableView.rowHeight = 105 // UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        let header = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreenWidth, height: kBannerHeight)))
        tableView.tableHeaderView = header
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
        }
        tableView.backgroundColor = .blue
        tableView.alwaysBounceVertical = true
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        return tableView
    }()
    */
    
    lazy fileprivate var viewModel = DCourseDetailViewModel()
    
    lazy fileprivate var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.setLayerShadow(UIColor(white: 0, alpha: 0.2), offset: CGSize(width: 0, height: 3), radius: 0.5)
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        return view
    }()
    
    lazy fileprivate var introductionBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor("#101010"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("课程介绍", for: .normal)
        button.addTarget(self, action: #selector(categoryBtnAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var catalogueBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor("#777"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("课程目录", for: .normal)
        button.addTarget(self, action: #selector(categoryBtnAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var evaluationBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor("#777"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("互动", for: .normal)
        button.addTarget(self, action: #selector(categoryBtnAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var categoryIndicatorImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor("#00a7a9")
        return imgView
    }()
    
    lazy fileprivate var toolView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.setLayerShadow(UIColor(white: 0, alpha: 0.2), offset: CGSize(width: 0, height: -2.5), radius: 2.5)
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        return view
    }()
    
    lazy fileprivate var favoriteBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIConstants.body.color, for: .normal)
        button.titleLabel?.font = UIConstants.body.font
//        button.addTarget(self, action: #selector(<#BtnAction#>), for: .touchUpInside)
        return button
    }()
    
    lazy fileprivate var favoriteImgView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 22, height: 20)))
        imgView.image = UIImage(named: "course_favoriteNormal")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy fileprivate var favoriteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor("#999")
        label.text = "收藏"
        return label
    }()
    
    lazy fileprivate var toolActionBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2.5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIConstants.body.font
        button.setTitle("立即学习", for: .normal)
        button.backgroundColor = UIColor("#00a7a9")
//        button.addTarget(self, action: #selector(<#BtnAction#>), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.setNavigationBarHidden(true, animated: true)
        
        navigationItem.title = "课程详情"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "public_shareBarItem")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(shareBarItemAction))
        
        initContentView()
        initConstraints()
        addNotificationObservers()
        
        viewModel.fetchCourse { (bool) in
            self.reload()
        }
    }
    
    // MARK: - ============= Initialize View =============
    func initContentView() {
//        view.addSubviews(mainScrollView)
        
//        mainScrollView.addSubviews(categoryScrollView)
//        mainScrollView.addSubviews(introductionScrollView, catalogueTableView, evaluationTableView, bannerView)
        
        
        
        tableView.estimatedRowHeight = 800
        tableView.register(CourseIntroductionCell.self, forCellReuseIdentifier: CourseIntroductionCell.className())
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubviews(tableView, toolView, categoryView)
        
        initCategoryContentView()
        initToolContentView()
        setupHeaderView()
    }
    
    func initCategoryContentView() {
        let stackView: UIStackView = {
            let view = UIStackView()
            view.alignment = .fill
            view.axis = .horizontal
            view.distribution = .fillEqually
            return view
        }()
        stackView.addArrangedSubview(introductionBtn)
        stackView.addArrangedSubview(catalogueBtn)
        stackView.addArrangedSubview(evaluationBtn)
        
        let separatorImgView: UIImageView = {
            let imgView = UIImageView()
            imgView.backgroundColor = UIColor("#f3f4f6")
            return imgView
        }()
        categoryView.addSubviews(stackView, separatorImgView, categoryIndicatorImgView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        separatorImgView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        categoryIndicatorImgView.snp.makeConstraints { make in
            make.centerX.equalTo(introductionBtn)
            make.width.equalTo(27.5)
            make.height.equalTo(1.5)
            make.bottom.equalToSuperview()
        }
    }
    
    func initToolContentView() {
        toolView.addSubviews(favoriteBtn, toolActionBtn)
        favoriteBtn.addSubviews(favoriteImgView, favoriteLabel)

    }
    
    // MARK: - ============= Constraints =============
    func initConstraints() {
        toolView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(55)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(toolView.snp.top)
        }
        categoryView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo((tableView.tableHeaderView?.bounds.size.height ?? 0) - 62)
            make.height.equalTo(62)
        }
        favoriteBtn.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(52)
        }
        favoriteImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
            make.width.equalTo(22)
            make.height.equalTo(20)
        }
        favoriteLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(favoriteImgView.snp.bottom).offset(6)
        }
        toolActionBtn.snp.makeConstraints { make in
            make.leading.equalTo(favoriteBtn.snp.trailing).offset(10)
            make.trailing.equalTo(-25)
            make.top.equalTo(7.5)
            make.bottom.equalTo(-7.5)
        }
//        mainScrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        bannerView.snp.makeConstraints { make in
//            make.leading.top.trailing.equalToSuperview()
//            make.height.equalTo(kBannerHeight)
//        }
//        categoryScrollView.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(453)
//            make.height.equalTo(UIScreenHeight+453)
//            make.width.equalTo(UIScreenWidth)
//        }
//        introductionScrollView.snp.makeConstraints { make in
//            make.top.equalTo(0)
//            make.leading.bottom.equalToSuperview()
//            make.width.equalTo(UIScreenWidth)
//            make.height.equalTo(UIScreenHeight)
//        }
//        catalogueTableView.snp.makeConstraints { make in
//            make.top.equalTo(0)
//            make.leading.equalTo(introductionScrollView.snp.trailing)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(introductionScrollView.snp.width)
//            make.height.equalTo(UIScreenHeight)
//        }
//        evaluationTableView.snp.makeConstraints { make in
//            make.top.equalTo(0)
//            make.leading.equalTo(catalogueTableView.snp.trailing)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(introductionScrollView.snp.width)
//            make.trailing.equalToSuperview()
//            make.height.equalTo(UIScreenHeight)
//        }
    }
    
    // MARK: - ============= Notification =============
    func addNotificationObservers() {
        
    }
    
    // MARK: - ============= Request =============
    
    // MARK: - ============= Reload =============
    @objc func reload() {
        tableView.reloadData()
        setupHeaderView()
        
    }
    
    // MARK: - ============= Action =============
    
    @objc func categoryBtnAction(sender: UIButton) {
        
        categoryIndicatorImgView.snp.remakeConstraints { make in
            make.centerX.equalTo(sender)
            make.width.equalTo(27.5)
            make.height.equalTo(1.5)
            make.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.25) {
            self.categoryView.layoutIfNeeded()
        }
        
        introductionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        catalogueBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        evaluationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        introductionBtn.setTitleColor(UIColor("#777"), for: .normal)
        introductionBtn.setTitleColor(UIColor("#777"), for: .normal)
        introductionBtn.setTitleColor(UIColor("#777"), for: .normal)
        
        sender.setTitleColor(UIColor("#101010"), for: .normal)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    @objc func shareBarItemAction() {
        
    }
    
    /*
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if let object = object as? UIScrollView {
//                if bannerView.frame.origin.y + bannerView.frame.size.height > 0 {
//                    bannerView.centerY = -(lastContentOffsetY-object.contentOffset.y)
//                    lastContentOffsetY = object.contentOffset.y
                    bannerView.snp.remakeConstraints { make in
                        make.top.equalTo(-(object.contentOffset.y))
                        make.leading.trailing.equalToSuperview()
                        make.height.equalTo(kBannerHeight)
                    }
//                }
                
            }
            
        }
    }
 */
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        if scrollView == mainScrollView {
//            if mainScrollView.contentOffset.y > 453 {
//                catalogueTableView.isScrollEnabled = true
//                evaluationTableView.isScrollEnabled = true
//            } else {
//                catalogueTableView.isScrollEnabled = false
//                evaluationTableView.isScrollEnabled = false
//            }
////        }
//    }
    
    deinit {
//        introductionScrollView.removeObserver(self, forKeyPath: "contentOffset")
//        catalogueTableView.removeObserver(self, forKeyPath: "contentOffset")
//        evaluationTableView.removeObserver(self, forKeyPath: "contentOffset")
    }
}


extension DCourseDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupHeaderView() {
        
        let headerView: UIView = {
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreenWidth, height: 390+62)))
            view.backgroundColor = .white
            return view
        }()
        
        let bannerView: UIView = {
            let view = UIView()
            view.clipsToBounds = true
            return view
        }()
        let bannerImgView: UIImageView = {
            let imgView = UIImageView()
            imgView.contentMode = .scaleAspectFill
            return imgView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.textColor = UIColor("#222")
            label.numberOfLines = 5
            return label
        }()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor("#777")
            return label
        }()
        
        let footnoteLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor("#f26a44")
            return label
        }()
        
        let tagLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor("#ccc")
            return label
        }()
        
        headerView.addSubviews(bannerView, titleLabel, descriptionLabel, footnoteLabel, tagLabel)
        bannerView.addSubview(bannerImgView)
        
        bannerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        bannerImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.top.equalTo(bannerView.snp.bottom).offset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(12)
        }
        footnoteLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.height.equalTo(12)
        }
        tagLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-25)
            make.centerY.equalTo(footnoteLabel)
        }
        
        if let URLString = viewModel.courseModel?.cover_attribute?.service_url {
            bannerImgView.kf.setImage(with: URL(string: URLString))
        }
        
        
        let attributedString = NSMutableAttributedString(string: viewModel.courseModel?.title ?? "")
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10
        attributedString.addAttributes([
            NSAttributedString.Key.paragraphStyle: paragraph], range: NSRange(location: 0, length: attributedString.length))
        titleLabel.attributedText = attributedString
        
        descriptionLabel.text = "适合人群：" + (viewModel.courseModel?.suitable ?? "")
        footnoteLabel.text = String(viewModel.courseModel?.students_count ?? 0) + "人已学习"
        tagLabel.text = "已购买"
        
        var titleHeight = titleLabel.systemLayoutSizeFitting(CGSize(width: (UIScreenWidth-50)/2, height: CGFloat.greatestFiniteMagnitude)).height
        if titleHeight < titleLabel.font.lineHeight*2 {
            let attributedString = NSMutableAttributedString(string: viewModel.courseModel?.title ?? "")
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 0
            attributedString.addAttributes([
                NSAttributedString.Key.paragraphStyle: paragraph], range: NSRange(location: 0, length: attributedString.length))
            titleLabel.attributedText = attributedString
            
            
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(25)
                make.trailing.equalTo(-25)
                make.top.equalTo(bannerView.snp.bottom).offset(20)
                make.height.equalTo(25)
            }
            titleHeight = 25
        }
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreenWidth, height: 200+20+titleHeight+20+12+10+12+25+62))
        tableView.tableHeaderView = headerView
        
        categoryView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo((tableView.tableHeaderView?.bounds.size.height ?? 0) - 62)
            make.height.equalTo(62)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseIntroductionCell.className(), for: indexPath) as! CourseIntroductionCell
        if let model = viewModel.courseModel {
            cell.setup(model: model)
        }
        return cell
    }
}

extension DCourseDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == mainScrollView {
//            if scrollView.contentOffset.y > 453 {
//                catalogueTableView.isScrollEnabled = true
//                evaluationTableView.isScrollEnabled = true
//            } else {
//                catalogueTableView.isScrollEnabled = false
//                evaluationTableView.isScrollEnabled = false
//            }
//        }
        
        var offsetY = (tableView.tableHeaderView?.bounds.size.height ?? 0) - 62 - scrollView.contentOffset.y
        if offsetY < 0 {
            offsetY = 0
        }
        categoryView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(offsetY)
            make.height.equalTo(62)
        }
    }
}
