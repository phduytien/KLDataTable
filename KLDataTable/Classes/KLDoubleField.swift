//
//  File.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 5/3/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMaterialKeyboard

/// For inputting unsigned intergral numbers.
class KLDoubleField: KLTextField {
    
    var minValue: Double = 0
    var maxValue: Double = Double.infinity
    
    var numberOfDigits: UInt = 0 {
        didSet {
            text = String(format: "%.\(numberOfDigits)f", self.value)
        }
    }
    
    var value: Double = 0 {
        didSet {
            text = String(format: "%.\(numberOfDigits)f", self.value)
            sendActions(for: .valueChanged)
        }
    }
    
        
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override init(_ theme: DataTableTheme = .light, placeholder: String = "") {
        super.init(theme, placeholder: placeholder)
        delegate = self
    }
    
}

class KLLargeDoubleField: KLDoubleField {
    
    override func prepare() {
        super.prepare()
        textColor = theme.textColor
        font = theme.xxlargeInputFont
        placeholderActiveScale = 0.45
        placeholderVerticalOffset = 12.0
    }
    
}

extension Reactive where Base: KLDoubleField {
    
    /// Reactive wrapper for `text` property.
    var value: ControlProperty<Double> {
        return base.rx.controlProperty(
            editingEvents: [.allEditingEvents, .valueChanged],
            getter: { $0.value },
            setter: { field, value in field.value = value }
        )
    }
    /// Reactive wrapper for `text` property.
    var numberOfDigits: ControlProperty<UInt> {
        return base.rx.controlProperty(
            editingEvents: [.allEditingEvents, .valueChanged],
            getter: { $0.numberOfDigits },
            setter: { field, value in field.numberOfDigits = value }
        )
    }
    
}

extension KLDoubleField: KeyActionHandler {
    
    func interested(in: KeyAction) -> Bool {
        return true
    }
    
    func apply(key: KeyAction) {
        apply(key: key, to: self)
    }
    
    func apply(key: KeyAction, to field: UITextField) {
        let base = pow(10, Double(numberOfDigits))
        let roundValue = lround(value*base)
        switch key {
        case .char(let char):
            guard let v = Int(char) else { return }
            let nvalue = Double(roundValue*10 + v)/base
            if nvalue >= minValue && nvalue <= maxValue {
                value = nvalue
            }
        case .clear:
            value = 0
        case .backspace:
            let nvalue = Double(roundValue/10)/base
            if nvalue >= minValue, nvalue <= maxValue {
                value = nvalue
            }
        case .add(let v):
            let nvalue = value + Double(v)
            if nvalue >= minValue, nvalue <= maxValue {
                value = nvalue
            }
        case .minus(let v):
            let nvalue = value - Double(v)
            if nvalue >= minValue, nvalue <= maxValue {
                value = nvalue
            }
        default: return
        }
    }
    
}

extension KLDoubleField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let _ = Double(string) else { return false }
        return true
    }
    
}
