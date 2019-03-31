//
//  KLCellsView.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 6/29/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import UIKit

class KLCellsView: UIView {
    
    var cells: [(UIView, KLDataTableColumnType)] = [] {
        didSet {
            for v in subviews {
                v.removeFromSuperview()
            }
            for c in cells {
                addSubview(c.0)
            }
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let fixedWidth: CGFloat = cells.reduce(0) { (width, cell) in
            width + cell.1.width.width
        }
        let dynamicCellCount: CGFloat =  CGFloat(cells.filter { $0.1.width == .flex }.count)
        let dynamicWidth: CGFloat = max((frame.size.width - fixedWidth) / dynamicCellCount, 0)
        var x: CGFloat = 0
        for (view, type) in cells {
            let w = type.width == .flex ? dynamicWidth : type.width.width
            view.frame = CGRect(x: x + 4, y: 0, width: w - 8, height: frame.size.height)
            x += w
        }
    }

}
