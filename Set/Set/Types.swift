//
//  Types.swift
//  Set
//
//  Created by Mustafo on 03/05/21.
//

import SwiftUI

enum SetShape : Hashable, CaseIterable{
    case diamond, squiggle, oval
    
    
}
enum NumberOfShapes : Int, Hashable, CaseIterable {
    case one = 1, two, three
}
enum Shading : Hashable, CaseIterable {
    case solid, striped,  open
    
    
}
enum ShapeColor : Hashable, CaseIterable{
    case red
    case green
    case purple
    
   
}

