//
//  KLFlatButton.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 6/11/17.
//  Copyright © 2017 Willbe Technology. All rights reserved.
//

import Foundation
import Material

/// Flat button for displaying with icon
class KLFlatButton: FlatButton {
    
    var theme: DataTableTheme
    
    required init?(coder aDecoder: NSCoder) {
        self.theme = .mainTheme
        super.init(frame: .zero)
    }
    
    init(_ theme: DataTableTheme = DataTableTheme.mainTheme) {
        self.theme = theme
        super.init(frame: .zero)
    }
    
    open override func prepare() {
        super.prepare()
        contentEdgeInsetsPreset = .wideRectangle2
        titleLabel?.font = theme.normalFont
        titleColor = theme.textColor
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.25
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: max(theme.normalButtonHeight, size.width), height: max(theme.normalButtonHeight, size.height))
    }
    
}

