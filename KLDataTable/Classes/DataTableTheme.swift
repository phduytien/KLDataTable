//
//  DataTableTheme.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 4/24/17.
//  Copyright © 2017 Willbe Technology. All rights reserved.
//

import Foundation
import Material

open class DataTableTheme {

    var isDarkTheme = true
    
    public static let mainTheme = DataTableTheme.dark
    public static let light = DataTableTheme(isDarkTheme: false)
    public static let dark = DataTableTheme(isDarkTheme: true)
    
    init(isDarkTheme: Bool) {
        self.isDarkTheme = isDarkTheme
    }
    
    var primary: ColorPalette.Type {
        return isDarkTheme ? Material.Color.blueGrey.self : Material.Color.teal.self
    }
    
    var secondary: ColorPalette.Type {
        return isDarkTheme ? Material.Color.teal.self : Material.Color.grey.self
    }
    
    var warn: ColorPalette.Type {
        return Material.Color.deepOrange.self
    }
    
    var secondaryTextColor: UIColor {
        return isDarkTheme ? Material.Color.lightText.secondary : Material.Color.darkText.secondary
    }
    
    // MARK: Colors

    var textColor: UIColor {
        return isDarkTheme ? Material.Color.lightText.primary : Material.Color.darkText.primary
    }
    
    var dividersColor: UIColor {
        return isDarkTheme ? Material.Color.lightText.dividers : Material.Color.darkText.dividers
    }
    
    // MARK: - Fonts
    
    var normalFontSize: CGFloat { return 16.0 }
    var normalFont: UIFont { return RobotoFont.medium(with: normalFontSize) }
    var normalBoldFont: UIFont { return RobotoFont.bold(with: normalFontSize) }
    var smallFont: UIFont { return RobotoFont.medium(with: 14.0) }
    var xsmallFont: UIFont { return RobotoFont.medium(with: 12.0) }
    var xlargeInputFont: UIFont { return RobotoFont.bold(with: 20.0) }
    var xxlargeInputFont: UIFont { return RobotoFont.bold(with: 24.0) }

    // MARK: - Dimensions
    
    var guideline: CGFloat { return InterimSpacePresetToValue(preset: .interimSpace4) }
    var buttonHeight: CGFloat { return CGFloat(HeightPreset.default.rawValue) }
    var normalButtonHeight: CGFloat { return CGFloat(HeightPreset.normal.rawValue) }

}
