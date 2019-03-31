//
//  KLDataTableColumn.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 5/9/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import RxSwift

fileprivate let cellSpacing: CGFloat = 12.0

enum KLDataTableColumnWidthType {
    case fixed(width: CGFloat)
    case flex
    
    var width: CGFloat {
        switch self {
        case .fixed(let width):
            return width
        default:
            return 0
        }
    }
}

func ==(lhs: KLDataTableColumnWidthType, rhs: KLDataTableColumnWidthType) -> Bool {
    switch (lhs, rhs) {
    case (.flex, .flex):
        return true
    case let (.fixed(w1), .fixed(w2)):
        return w1 == w2
    default:
        return false
    }
}

open class KLDataTableColumnType {
    
    let alignment: NSTextAlignment
    let width: KLDataTableColumnWidthType
    
    convenience init(alignment: NSTextAlignment, fixed width: CGFloat) {
        self.init(alignment: alignment, width: .fixed(width: width))
    }
    
    init(alignment: NSTextAlignment, width: KLDataTableColumnWidthType = .flex) {
        self.alignment = alignment
        self.width = width
    }
    
    public static var number: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .right, width: .fixed(width: 48))
    }
    public static var largeNumber: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .right, width: .fixed(width: 64))
    }
    public static var currency: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .right, width: .fixed(width: 96))
    }
    public static var tip: KLDataTableColumnType {
        return TipDataTableColumnType(alignment: .right, width: .fixed(width: 96))
    }
    public static var name: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .left)
    }
    public static var leftFlex: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .left)
    }
    public static var icon: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .center, width: .fixed(width: 20))
    }
    public static var checkbox: KLDataTableColumnType {
        return CheckBoxDataTableColumnType(alignment: .center, width: .fixed(width: 44))
    }
    public static var time: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .center, width: .fixed(width: 52))
    }
    public static var date: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .center, width: .fixed(width: 104))
    }
    public static var orderStatus: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .left, width: .fixed(width: 48))
    }
    public static var transType: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .left, width: .fixed(width: 160))
    }
    public static var cardType: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .left, width: .fixed(width: 80))
    }
    public static var cardNumber: KLDataTableColumnType {
        return KLDataTableColumnType(alignment: .left, width: .fixed(width: 48))
    }
    
}

class TipDataTableColumnType: KLDataTableColumnType {}
class CheckBoxDataTableColumnType: KLDataTableColumnType {}

public typealias KLDataTableFormatCell<T> = (_ obj: T, _ cell: UIView, _ disposeBag: DisposeBag) -> Void

/// Column definition
open class KLDataTableColumn<T> {
    
    let name: NSAttributedString
    let type: KLDataTableColumnType
    let value: (_ obj: T) -> String
    let format: KLDataTableFormatCell<T>
    
    let lines: Int
    
    public convenience init(name: String, type: KLDataTableColumnType, lines: Int = 1, value: @escaping (_ obj: T) -> String, format: @escaping KLDataTableFormatCell<T> = { (_, _, _) in }) {
        self.init(name: NSAttributedString(string: name), type: type, lines: lines, value: value, format: format)
    }
    
    public init(name: NSAttributedString, type: KLDataTableColumnType, lines: Int = 1, value: @escaping (_ obj: T) -> String, format: @escaping KLDataTableFormatCell<T> = { (_, _, _) in }) {
        self.name = name
        self.type = type
        self.lines = lines
        self.value = value
        self.format = format
    }
    
}
