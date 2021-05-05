//
//  AnyShape.swift
//  Set
//
//  Created by Mustafo on 04/05/21.
//

import SwiftUI

struct AnyShape : Shape {
    private let path : (CGRect) -> Path
    
    init<S:Shape>(_ wrapped: S) {
        path = { rect in
            wrapped.path(in: rect)
        }
    }
    func path(in rect: CGRect) -> Path {
        path(rect)
    }
    
}

