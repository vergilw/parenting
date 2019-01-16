//
//  DVideoUserViewController.swift
//  parenting
//
//  Created by Vergil.Wang on 2019/1/10.
//  Copyright © 2019 zheng-chain. All rights reserved.
//

import UIKit

class DVideoUserViewController: BaseViewController {

    var userID: Int?
    
    var videoModels: [VideoModel]?
    
    fileprivate lazy var pageNumber: Int = 1
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (UIScreenWidth-2)/3.0
        layout.itemSize = CGSize(width: width, height: width/9.0*16)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if #available(iOS 11, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        view.showsVerticalScrollIndicator = false
        view.register(VideoUserCell.self, forCellWithReuseIdentifier: VideoUserCell.className())
        view.register(VideoUserHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: VideoUserHeaderView.className())
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        
        view.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self, weak view] in
            self?.fetchMoreData()
        })
        view.mj_footer.isHidden = true
        
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "小视频"
        
        initContentView()
        initConstraints()
        addNotificationObservers()
        
        fetchData()
    }
    
    // MARK: - ============= Initialize View =============
    fileprivate func initContentView() {
        view.addSubview(collectionView)
    }
    
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - ============= Notification =============
    fileprivate func addNotificationObservers() {
        
    }
    
    // MARK: - ============= Request =============
    fileprivate func fetchData() {
        HUDService.sharedInstance.showFetchingView(target: self.view)
        
        VideoProvider.request(.videos_user(userID ?? 0, 1), completion: ResponseService.sharedInstance.response(completion: { (code, JSON) in
            
            HUDService.sharedInstance.hideFetchingView(target: self.view)
            
            if code >= 0 {
                if let data = JSON?["videos"] as? [[String: Any]] {
                    
                    self.pageNumber = 1
                    
                    if let models = [VideoModel].deserialize(from: data) as? [VideoModel] {
                        self.videoModels = models
                    }
                    self.collectionView.reloadData()
                    
                    if let pagination = JSON?["pagination"] as? [String: Any], let totalPages = pagination["total_pages"] as? Int {
                        if totalPages > self.pageNumber {
                            self.pageNumber += 1
                            self.collectionView.mj_footer.isHidden = false
                            self.collectionView.mj_footer.resetNoMoreData()
                            
                        } else {
                            self.collectionView.mj_footer.isHidden = true
                        }
                    }
                }
                
            } else if code == -2 {
                HUDService.sharedInstance.showNoNetworkView(target: self.view) { [weak self] in
                    self?.fetchData()
                }
            }
        }))
    }
    
    fileprivate func fetchMoreData() {
        
        VideoProvider.request(.videos_user(userID ?? 0, pageNumber), completion: ResponseService.sharedInstance.response(completion: { (code, JSON) in
            
            self.collectionView.mj_footer.endRefreshing()
            
            if code >= 0 {
                if let data = JSON?["videos"] as? [[String: Any]] {
                    if let models = [VideoModel].deserialize(from: data) as? [VideoModel] {
                        self.videoModels?.append(contentsOf: models)
                    }
                    self.collectionView.reloadData()
                    
                    if let pagination = JSON?["pagination"] as? [String: Any], let totalPages = pagination["total_pages"] as? Int {
                        if totalPages > self.pageNumber {
                            self.pageNumber += 1
                            self.collectionView.mj_footer.endRefreshing()
                        } else {
                            self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    }
                }
                
            }
        }))
    }
    
    // MARK: - ============= Reload =============
    @objc func reload() {
        
    }
    
    // MARK: - ============= Action =============

}


extension DVideoUserViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreenWidth, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: VideoUserHeaderView.className(), for: indexPath)
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoUserCell.className(), for: indexPath) as! VideoUserCell
        if let model = videoModels?[exist: indexPath.row] {
            cell.setup(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let models = videoModels {
            navigationController?.pushViewController(DVideoDetailViewController(models: models, index: indexPath.row), animated: true)
        }
    }
    
}


