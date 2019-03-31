//
//  KLDataTableSummaryCell.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 4/15/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Material
import SnapKit

/// Column definition
open class KLDataTableSummaryCell<T> {
    
    public typealias KLDataTableSummaryValue = (_ obj: T) -> String

    var type: KLDataTableColumnType!
    var value: KLDataTableSummaryValue!
    
    public init(type: KLDataTableColumnType, value: @escaping KLDataTableSummaryValue) {
        self.type = type
        self.value = value
    }
    
}
