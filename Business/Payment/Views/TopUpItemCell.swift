//
//  TopUpItemCell.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/11/14.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import UIKit

class TopUpItemCell: UICollectionViewCell {
    
    lazy fileprivate var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 5
        return view
    }()
    
    lazy fileprivate var gainLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.h2
        label.textColor = UIConstants.Color.primaryGreen
        label.text = "0"
        return label
    }()
    
    lazy fileprivate var costLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.foot
        label.textColor = UIConstants.Color.primaryGreen
        label.text = "0"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 5
        layer.borderColor = UIConstants.Color.primaryGreen.cgColor
        layer.borderWidth = 0.5
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(gainLabel)
        stackView.addArrangedSubview(costLabel)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        costLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        gainLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setup(model: AdvanceModel) {
        if let gain = model.wallet_amount {
            gainLabel.text = String.integerFormatter.string(from: NSNumber(string: gain) ?? 0)
        }
        
        if let cost = model.final_price {
            costLabel.text = (String.integerFormatter.string(from: NSNumber(string: cost) ?? 0) ?? "") + "元"
        }
        
        
    }
    
    func setupExchange(model: RewardExchangeModel, isEnabled: Bool) {
        if let gain = model.wallet_amount {
            let string = (String.integerFormatter.string(from: NSNumber(string: gain) ?? 0) ?? "") + "氧育币"
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIConstants.Color.foot, NSAttributedString.Key.font: UIConstants.Font.foot, NSAttributedString.Key.baselineOffset: 1.25], range: NSString(string: string).range(of: "氧育币"))
            gainLabel.attributedText = attributedString
//            gainLabel.text = (String.integerFormatter.string(from: NSNumber(string: gain) ?? 0) ?? "") + "氧育币"
        }
        
        if let cost = model.coin_amount {
            costLabel.text = (String.integerFormatter.string(from: NSNumber(string: cost) ?? 0) ?? "") + "金币"
        }
        
        if isEnabled {
            layer.borderColor = UIConstants.Color.primaryGreen.cgColor
            gainLabel.textColor = UIConstants.Color.primaryGreen
            costLabel.textColor = UIConstants.Color.primaryGreen
        } else {
            layer.borderColor = UIConstants.Color.disable.cgColor
            gainLabel.textColor = UIConstants.Color.disable
            costLabel.textColor = UIConstants.Color.disable
        }
    }
    
    func setupWithdraw(model: WithdrawModel, isEnabled: Bool) {
        if let gain = model.cash_amount {
            let string = (String.integerFormatter.string(from: NSNumber(string: gain) ?? 0) ?? "") + "元"
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIConstants.Color.foot, NSAttributedString.Key.font: UIConstants.Font.foot, NSAttributedString.Key.baselineOffset: 1.25], range: NSString(string: string).range(of: "元"))
            gainLabel.attributedText = attributedString
//            gainLabel.text = (String.integerFormatter.string(from: NSNumber(string: gain) ?? 0) ?? "") + "元"
        }
        
        if let cost = model.coin_amount {
            costLabel.text = "兑" + (String.integerFormatter.string(from: NSNumber(string: cost) ?? 0) ?? "") + "金币"
        }
        
        if isEnabled {
            layer.borderColor = UIConstants.Color.primaryGreen.cgColor
            gainLabel.textColor = UIConstants.Color.primaryGreen
            costLabel.textColor = UIConstants.Color.primaryGreen
        } else {
            layer.borderColor = UIConstants.Color.disable.cgColor
            gainLabel.textColor = UIConstants.Color.disable
            costLabel.textColor = UIConstants.Color.disable
        }
    }
}

