//
//  DMeMessagesViewController.swift
//  parenting
//
//  Created by Vergil.Wang on 2019/2/27.
//  Copyright © 2019 zheng-chain. All rights reserved.
//

import UIKit

class DMeMessagesViewController: BaseViewController {

    fileprivate lazy var pageNumber: Int = 1
    
    fileprivate var messageModels: [MessageModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "消息中心"

        initContentView()
        initConstraints()
        addNotificationObservers()
        
        fetchData()
    }
    
    // MARK: - ============= Initialize View =============
    fileprivate func initContentView() {
        initNavigationItem()
        
        tableView.rowHeight = 88
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIConstants.Margin.leading+62, bottom: 0, right: UIConstants.Margin.trailing)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIConstants.Color.separator
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.className())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.fetchMoreData()
        })
        tableView.mj_footer.isHidden = true
        
        view.addSubview(tableView)
    }
    
    fileprivate func initNavigationItem() {
        let asReadBtn: ActionButton = {
            let button = ActionButton()
            button.setIndicatorColor(UIConstants.Color.primaryGreen)
            button.frame = CGRect(origin: .zero, size: CGSize(width: 60+UIConstants.Margin.trailing*2, height: navigationController?.navigationBar.bounds.height ?? 44))
            button.setTitleColor(UIConstants.Color.head, for: .normal)
            button.titleLabel?.font = UIConstants.Font.h3
            button.setTitle("全部已读", for: .normal)
            button.addTarget(self, action: #selector(asReadBtnAction(sender:)), for: .touchUpInside)
            return button
        }()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: asReadBtn)
        navigationItem.rightBarButtonItem?.width = 60+UIConstants.Margin.trailing*2
        navigationItem.rightMargin = 0
    }
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - ============= Notification =============
    fileprivate func addNotificationObservers() {
        
    }
    
    // MARK: - ============= Request =============
    fileprivate func fetchData() {
        HUDService.sharedInstance.showFetchingView(target: self.view)
        
        MessageProvider.request(.messages(1), completion: ResponseService.sharedInstance.response(completion: { (code, JSON) in
            
            HUDService.sharedInstance.hideFetchingView(target: self.view)
            
            if code >= 0 {
                if let data = JSON?["notifications"] as? [[String: Any]] {
                    if let models = [MessageModel].deserialize(from: data) as? [MessageModel] {
                        self.messageModels = models
                    }
                    self.tableView.reloadData()
                    
                    if let meta = JSON?["meta"] as? [String: Any], let pagination = meta["pagination"] as? [String: Any], let totalPages = pagination["total_pages"] as? Int {
                        if totalPages > self.pageNumber {
                            self.pageNumber = 2
                            self.tableView.mj_footer.isHidden = false
                            self.tableView.mj_footer.resetNoMoreData()
                            
                        } else {
                            self.tableView.mj_footer.isHidden = true
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
        
        MessageProvider.request(.messages(pageNumber), completion: ResponseService.sharedInstance.response(completion: { (code, JSON) in
            
            self.tableView.mj_footer.endRefreshing()
            
            if code >= 0 {
                if let data = JSON?["notifications"] as? [[String: Any]] {
                    if let models = [MessageModel].deserialize(from: data) as? [MessageModel] {
                        self.messageModels?.append(contentsOf: models)
                    }
                    self.tableView.reloadData()
                    
                    if let meta = JSON?["meta"] as? [String: Any], let pagination = meta["pagination"] as? [String: Any], let totalPages = pagination["total_pages"] as? Int {
                        if totalPages > self.pageNumber {
                            self.pageNumber += 1
                            self.tableView.mj_footer.endRefreshing()
                        } else {
                            self.tableView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    }
                }
                
            }
        }))
    }
    
    fileprivate func asReadRequest(messageID: Int) {
        
        MessageProvider.request(.message(messageID), completion: ResponseService.sharedInstance.response(completion: { (code, JSON) in
            
            if code >= 0 {
                NotificationCenter.default.post(name: Notification.Message.messageUnreadCountDidChange, object: nil)
            }
        }))
    }
    
    // MARK: - ============= Reload =============
    @objc func reload() {
        
    }
    
    // MARK: - ============= Action =============
    @objc fileprivate func asReadBtnAction(sender: ActionButton) {
        sender.startAnimating()
        
        MessageProvider.request(.messages_asReadAll, completion: ResponseService.sharedInstance.response(completion: { (code, JSON) in
        
            sender.stopAnimating()
            
            if code >= 0 {
                for model in self.messageModels ?? [] {
                    model.read_at = Date()
                }
                self.tableView.reloadData()
                
                HUDService.sharedInstance.show(string: "全部已读成功")
            }
        }))
    }
    
    // MARK: - ============= Public =============
    
    // MARK: - ============= Private =============

}


extension DMeMessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.className(), for: indexPath) as! MessageCell
        if let model = messageModels?[exist: indexPath.row] {
            cell.setup(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let model = messageModels?[exist: indexPath.row], let string = model.link, let url = URL(string: string), let messageID = model.id {
            guard let viewController = RouteService.shared.route(URI: url) else { return }
            navigationController?.pushViewController(viewController, animated: true)
            
            model.read_at = Date()
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            
            asReadRequest(messageID: messageID)
        }
    }
}
