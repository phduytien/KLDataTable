//
//  KLCashField.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 5/10/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMaterialKeyboard

/// For inputting unsigned intergral numbers.
class KLCashField: KLDoubleField {
    
    override var value: Double {
        didSet {
            text = value.asMoney
            sendActions(for: .valueChanged)
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override init(_ theme: DataTableTheme = .light, placeholder: String = "") {
        super.init(theme, placeholder: placeholder)
        minValue = 0
        maxValue = 99999999
        numberOfDigits = 2
        value = 0
    }
}

class KLLargeCashField: KLCashField {
    
    override func prepare() {
        super.prepare()
        textColor = theme.textColor
        font = theme.xxlargeInputFont
        placeholderActiveScale = 0.45
        placeholderVerticalOffset = 12.0
    }
    
}

class KLMediumCashField: KLCashField {
    
    override func prepare() {
        super.prepare()
        textColor = theme.textColor
        font = theme.xlargeInputFont
        placeholderActiveScale = 0.5
        placeholderVerticalOffset = 8.0
    }
    
}
