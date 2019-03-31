//
//  KLDataTable.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 6/16/17.
//  Copyright © 2017 Willbe Technology. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Material
import SnapKit
import DRPLoadingSpinner

/// For displaying data in table like format
open class KLDataTable<R, T>: KLView {
    
    let theme: DataTableTheme
    
    public lazy var table = KLTableView(theme)
    public let pagination = KLDataTablePagination()

    let wrapper = UIStackView()
    lazy var header = KLDataTableHeaderRow<T>(theme)
    let summary = KLDataTableSummary<T>()

    /// Child class to provide the definitions.
    public var columns: [KLDataTableColumn<T>] = [] {
        didSet {
            header.columns = columns
            for c in self.table.visibleCells {
                guard let c = c as? KLDataTableRow<T> else { continue }
                c.columns = columns
            }
        }
    }

    /// Child class to provide the definitions.
    public var summaryCells: [KLDataTableSummaryCell<T>] = [] {
        didSet {
            summary.cells = summaryCells
        }
    }

    /// Child class to override and provide custom implementation
    var cellType: AnyClass { return KLDataTableRow<T>.self }

    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
    }

    public init(_ theme: DataTableTheme = DataTableTheme.mainTheme) {
        self.theme = theme
        super.init(frame: .zero)

        backgroundColor = .clear

        wrapper.axis = .vertical
        wrapper.distribution = .fill
        wrapper.alignment = .fill
        addSubview(wrapper)
        wrapper.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        wrapper.addArrangedSubview(header)
        header.snp.makeConstraints { make in
            make.height.equalTo(theme.buttonHeight)
        }

        table.rowHeight = theme.normalButtonHeight
        table.register(cellType, forCellReuseIdentifier: "Cell")
        table.setContentHuggingPriority(.defaultLow, for: .vertical)
        wrapper.addArrangedSubview(table)

        wrapper.addArrangedSubview(summary)
        summary.snp.makeConstraints { make in
            make.height.equalTo(theme.buttonHeight)
        }

        wrapper.addArrangedSubview(pagination)
        pagination.snp.makeConstraints { make in
            make.height.equalTo(theme.buttonHeight)
        }

    }
    
}
