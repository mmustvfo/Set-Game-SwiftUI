//
//  Grid.swift
//  Memorize
//
//  Created by Mustafo on 25/02/21.
//

import SwiftUI

struct Grid<Item,ItemView>: View where Item: Identifiable,ItemView: View {
    
    var items:[Item]
    var itemForView: (Item) -> ItemView
    init(_ items:[Item],itemForView:@escaping (Item)-> ItemView) {
        self.items = items
        self.itemForView = itemForView
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) {item in
                let index = items.firstIndex(of: item)!
                let layout = GridLayout(itemCount: items.count, in: geometry.size)
                self.itemForView(item)
                    .frame(width:layout.itemSize.width,height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
    
    
}


