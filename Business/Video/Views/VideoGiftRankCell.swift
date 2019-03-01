//
//  VideoGiftRankCell.swift
//  parenting
//
//  Created by Vergil.Wang on 2019/3/1.
//  Copyright © 2019 zheng-chain. All rights reserved.
//

import UIKit
import Kingfisher

class VideoGiftRankCell: UITableViewCell {

    lazy fileprivate var sequenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.h2
        label.textColor = UIConstants.Color.disable
        return label
    }()
    
    lazy fileprivate var sequenceImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "payment_ranking0")
        imgView.isHidden = true
        return imgView
    }()
    
    lazy fileprivate var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "public_avatarPlaceholder")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy fileprivate var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.h4
        label.textColor = UIConstants.Color.head
        return label
    }()
    
    lazy fileprivate var valueLabel: PriceLabel = {
        let label = PriceLabel()
        label.font = UIConstants.Font.caption1
        label.textColor = UIConstants.Color.body
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubviews([sequenceLabel, sequenceImgView, avatarImgView, nameLabel, valueLabel])
        
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func initConstraints() {
        sequenceLabel.snp.makeConstraints { make in
            make.center.equalTo(sequenceImgView)
        }
        sequenceImgView.snp.makeConstraints { make in
            make.leading.equalTo(25)
            make.centerY.equalToSuperview()
        }
        avatarImgView.snp.makeConstraints { make in
            make.leading.equalTo(70)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImgView.snp.trailing).offset(8.5)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(valueLabel.snp.leading).offset(-12)
        }
        valueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-UIConstants.Margin.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    func setup(model: GiftRankModel) {
        if let position = model.position {
            if position < 4 {
                sequenceLabel.isHidden = true
                sequenceImgView.isHidden = false
                sequenceImgView.image = UIImage(named: "payment_ranking\(position)")
            } else {
                sequenceLabel.isHidden = false
                sequenceImgView.isHidden = true
                sequenceLabel.text = "\(position)"
            }
        }
        
        
        if let URLString = model.user?.avatar_url {
            avatarImgView.kf.setImage(with: URL(string: URLString), placeholder: UIImage(named: "public_avatarPlaceholder"))
        }
        
        nameLabel.text = model.user?.name
        
        valueLabel.text = "\(model.amount ?? "") 氧育币"
    }
}
