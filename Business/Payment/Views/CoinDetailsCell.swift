//
//  CoinDetailsCell.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/12/25.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import UIKit

class CoinDetailsCell: UITableViewCell {

    lazy fileprivate var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .leading
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 6
        return view
    }()
    
    lazy fileprivate var titleLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.font = UIConstants.Font.h2_regular
        label.textColor = UIConstants.Color.head
        return label
    }()
    
    lazy fileprivate var descLabel: ParagraphLabel = {
        let label = ParagraphLabel()
        label.font = UIConstants.Font.foot
        label.textColor = UIConstants.Color.foot
        return label
    }()
    
    lazy fileprivate var priceLabel: PriceLabel = {
        let label = PriceLabel()
        label.font = UIConstants.Font.h2
        label.textColor = UIConstants.Color.head
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
        
        contentView.addSubviews([stackView, priceLabel])
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)
        initConstraints()
    }
    
    fileprivate func initConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(UIConstants.Margin.leading)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-12)
            make.centerY.equalToSuperview()
        }
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-UIConstants.Margin.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        titleLabel.setParagraphText("购买课程")
        
        descLabel.setParagraphText("2018.10.30 08:25")
        
        priceLabel.setPriceText(text: "29.9", symbol: "-")
        
    }
    
}
