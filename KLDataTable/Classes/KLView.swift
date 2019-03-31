//
//  KLView.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 9/6/17.
//  Copyright © 2017 Willbe Technology. All rights reserved.
//

import Foundation
import Material

/// Base class for all view.
open class KLView: View {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience public init() {
        self.init(frame: .zero)
    }
    
}
