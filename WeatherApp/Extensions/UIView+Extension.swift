//
//  UIView+Extension.swift
//  Fandex
//
//  Created by Chandra Rao on 01/09/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyBorder(withBorderColor borderColor: UIColor?, withBorderWidth borderWidth: CGFloat?, andCornerRadius cornerRadius: CGFloat?) {
        if let color = borderColor, let border = borderWidth, let radius = cornerRadius {
            self.layer.masksToBounds = true
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = border
            self.layer.cornerRadius = radius
        }
    }
    func makeRoundedCorners(withCornerRadius cornerRadius: CGFloat?) {
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UILabel {
    func makeTextUnderLine(withText text: String, withUnderlineText underLineText: String, withTextColor textColor: UIColor, withUnderlineColor underlineColor: UIColor) {
        
        let rangeToUnderLine = (text as NSString).range(of: underLineText)
        let underLineTxt = NSMutableAttributedString(string: text, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Apple SD Gothic Neo", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0),
             NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.underlineColor: underlineColor]
        )
        underLineTxt.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeToUnderLine)
        underLineTxt.addAttributes([
            NSAttributedString.Key.foregroundColor: underlineColor
            ], range: rangeToUnderLine)
        self.attributedText = underLineTxt
    }
}

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}
