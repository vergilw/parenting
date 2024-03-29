//
//  PriceLabel.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/12/17.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import UIKit

class PriceLabel: UILabel {

    lazy fileprivate var strikethroughLayer: CAShapeLayer? = nil
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var intrinsicContentSize: CGSize {
        if let size = attributedText?.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil).size {
            return CGSize(width: size.width+0.5, height: font.lineHeight /*- (font.lineHeight - font.pointSize)*/)
        }

        return super.intrinsicContentSize
    }

    func setPriceText(text: String, discount: Float? = nil) {
        if let strikethroughLayer = strikethroughLayer {
            strikethroughLayer.removeFromSuperlayer()
            self.strikethroughLayer = nil
        }
        
        let formatterText: String = String.priceFormatter.string(from: (NSNumber(string: text) ?? NSNumber())) ?? ""
        var formatterDiscount: String?
        if let discount = discount, discount != 0 {
            formatterDiscount = String.priceFormatter.string(from: (NSNumber(value: discount)))
        }
        
        var text: String = "\(formatterText)"
        if let formatterDiscount = formatterDiscount {
            text = " \(formatterDiscount)  \(text)"
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: attributedString.length))
        if let formatterDiscount = formatterDiscount {
            attributedString.addAttributes([NSAttributedString.Key.font : UIConstants.Font.foot, NSAttributedString.Key.foregroundColor: UIColor("#cacaca")], range: NSString(string: text).range(of: " \(formatterDiscount) "))
        }
        attributedText = attributedString
        
        if let formatterDiscount = formatterDiscount {
            let strikethroughSize: CGSize = NSString(string: " \(formatterDiscount) ").boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: UIConstants.Font.foot], context: nil).size
            let size = attributedText?.size() ?? .zero
            let strikethroughHeight = (size.height - (size.height - strikethroughSize.height) + (font.lineHeight - font.pointSize)) / 2
                
            strikethroughLayer = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: 0, y: strikethroughHeight))
            linePath.addLine(to: CGPoint(x: strikethroughSize.width, y: strikethroughHeight))
            strikethroughLayer?.path = linePath.cgPath
            strikethroughLayer?.strokeColor = UIColor("#acacac").cgColor
            strikethroughLayer?.lineWidth = 1.0
            layer.addSublayer(strikethroughLayer!)
        }
    }
}
