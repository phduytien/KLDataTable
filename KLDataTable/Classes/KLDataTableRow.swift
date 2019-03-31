//
//  KLDataTableRow.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 5/9/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Material

/// For displaying row in cell format
open class KLDataTableRow<T>: KLTableViewCell {
    
    var disposeBag: DisposeBag?
    let theme = DataTableTheme.mainTheme
    
    private let border = CALayer()
    private let row = KLCellsView()
    
    var cells: [UIView] { return row.cells.map { $0.0 } }
    
    /// Show/hide selected indicator
    override open var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? theme.secondary.base : .clear
        }
    }
    
    override open func prepare() {
        super.prepare()
        
        addSubview(row)
        row.snp.makeConstraints { make in
            make.centerX.centerY.height.equalToSuperview()
            make.width.equalToSuperview().offset(-theme.guideline)
        }
        
        border.backgroundColor = theme.primary.lighten1.cgColor
        border.opacity = 0.1
        layer.addSublayer(border)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 2, y: frame.height, width: frame.width-4, height: 1)
    }
    
    
    /// Will be set to generate cells
    public var columns: [KLDataTableColumn<T>]? = nil {
        didSet {
            guard let columns = self.columns else {
                row.cells = []
                return
            }
            row.cells = columns.map { c in
                if c.type is TipDataTableColumnType {
                    let tip = AdjustTipField(theme)
                    tip.font = theme.smallFont
                    tip.dividerNormalColor = .white
                    tip.dividerActiveColor = .white
                    tip.textAlignment = .right
                    tip.dividerColor = .white
                    return (tip, c.type)
                } else {
                    let cellLabel = UILabel()
                    cellLabel.font = theme.xsmallFont
                    cellLabel.textColor = theme.textColor
                    cellLabel.textAlignment = c.type.alignment
                    return (cellLabel, c.type)
                }
            }
        }
    }
    
    /// Update value for this row.
    public var item: T? {
        didSet {
            // Break old bindings
            disposeBag = DisposeBag()
            // Make sure we the right inputs
            guard let columns = columns, columns.count == row.cells.count else {
                return
            }
            // Populate content
            for (index, col) in columns.enumerated() {
                if col.type is CheckBoxDataTableColumnType {
                    continue
                } else if col.type is TipDataTableColumnType {
                    guard let fld = row.cells[index].0 as? KLCashField else {
                        continue
                    }
                    guard let item = item else {
                        fld.value = 0
                        continue
                    }
                    col.format(item, fld, disposeBag!)
                } else {
                    guard let label = row.cells[index].0 as? UILabel else {
                        continue
                    }
                    guard let item = item else {
                        label.text = ""
                        continue
                    }
                    label.text = col.value(item)
                    col.format(item, label, disposeBag!)
                }
            }
        }
    }
    
    var cellTextColor: UIColor? {
        didSet {
            let color = cellTextColor ?? theme.textColor
            for (cell, _) in row.cells {
                if let lbl = cell as? UILabel {
                    lbl.textColor = color
                }
            }
        }
    }
    
}
