//
//  Extensions.swift
//  KLDataTable_Example
//
//  Created by Tien Pham on 3/31/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Material
import FontAwesomeKit

// MARK: - UIButton + FAK

extension UIButton {
    
    /// Convenient icon setting.
    var fakIcon: FAKIcon {
        set { set(icon: newValue) }
        get { fatalError("Invalid operation - having it here to avoid compiler error") }
    }
    
    /// Set icon with text and font.
    ///
    /// - Parameters:
    ///   - getIcon: to get the icon.
    ///   - text: the text string to set.
    func set(icon getIcon: @autoclosure () -> FAKIcon, withText text: String? = nil) {
        let color = titleColor(for: .normal)
        let font = titleLabel?.font
        let icon = getIcon()
        icon.addAttribute(NSAttributedStringKey.foregroundColor.rawValue, value: color)
        let str = NSMutableAttributedString(attributedString: icon.attributedString())
        if let text = text, text.isNotEmpty {
            str.append(NSAttributedString(string: "  \(text)", attributes: [
                NSAttributedStringKey.foregroundColor: color as Any,
                NSAttributedStringKey.font: font as Any]))
        }
        setAttributedTitle(str, for: .normal)
    }
    
    /// Change icon color for a UIButton.
    ///
    /// - Parameter color: the new color.
    func set(iconColor color: UIColor) {
        guard let attr = attributedTitle(for: .normal) else {
            return
        }
        let attrTitle = NSMutableAttributedString(attributedString: attr)
        attrTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: color as Any, range: NSMakeRange(0, attrTitle.length))
        setAttributedTitle(attrTitle, for: .normal)
    }
}

// MARK: - UILabewl + FAK

extension UILabel {
    
    /// Convenient icon setting.
    var fakIcon: FAKIcon {
        set {
            set(icon: newValue)
        }
        get {
            fatalError("Invalid operation - having it here to avoid compiler error")
        }
    }
    
    /// Set icon with text and font.
    ///
    /// - Parameters:
    ///   - getIcon: to get the icon.
    ///   - text: the text string to set.
    func set(icon getIcon: @autoclosure () -> FAKIcon, withText text: String? = nil) {
        let icon = getIcon()
        icon.addAttribute(NSAttributedStringKey.foregroundColor.rawValue, value: textColor)
        let str = NSMutableAttributedString(attributedString: icon.attributedString())
        if let text = text, text.isNotEmpty {
            str.append(NSAttributedString(string: "  \(text)", attributes: [
                NSAttributedStringKey.foregroundColor: textColor as Any,
                NSAttributedStringKey.font: font as Any]))
        }
        attributedText = str
    }
}

// MARK: - String

extension String {
    
    /// Convenient non empty check
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
}

// MARK: - Double

extension Double {
    
    /// Return currency formatted value.
    var asMoney: String {
        if self >= 0 {
            return String(format: "$%.02f", self)
        } else {
            return "(\(String(format: "$%.02f", -self)))"
        }
    }
    
}
