//
//  CardView.swift
//  Set
//
//  Created by Mustafo on 04/05/21.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct CardView: View{
    var card : Model.Card
    var numberOfCards : Int

    
    var body: some View {
        GeometryReader { geometry in
            content(size: geometry.size)
        }
    }
    
    func content(size : CGSize) -> some View{
        let shape = createShape()
        return ZStack {
            Rectangle().fill(Color.white)
            card.isChoosen ? Color.yellow.opacity(0.8) : .clear
            Rectangle().stroke(Color.blue)
            VStack {
                ForEach(0..<card.numberOfShapes.rawValue){ _ in
                   shape
                    
                }
            }
            .padding(11)
        }
        
        
    }
    
    
    private func createShape() -> some View {
        var shape : AnyShape
        
        switch (card.shape) {
        case .oval : shape = AnyShape(Ellipse())
        case .diamond : shape = AnyShape(Diamond())
        case .squiggle : shape = AnyShape(Rectangle())
        }
        
        return ZStack {
            if card.shading != .striped {
                shape
                    .fill(Color.white)
                shape
                    .fill(cardColor)
                    .opacity(cardOpacity)
                shape
                    .stroke(cardColor,lineWidth: CGFloat(numberOfCards / 7))
                    .opacity(card.shading == .open ? 1 : cardOpacity)
            } else {
                shape
                    .fill(
                        ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor.init(cardColor), .white), width: numberOfCards > 12 ? 2 : 4 , ratio: 2),scale: 1))
                    )
                shape
                    .stroke(cardColor)
            }
        }
       
    }
    
    var cardColor : Color{
        switch card.color {
        case .red : return Color.red
        case .green : return Color.green
        case .purple : return Color.purple
        }
    }
    
    var cardOpacity : Double {
        switch card.shading {
        case .solid : return 1.0
        default : return 0.0
        }
    }
    
}


extension CGImage {
  // width is for total, ratio is second stripe relative to full width
  static func stripes(colors: (UIColor, UIColor), width: CGFloat, ratio: CGFloat) -> CGImage {
    let filter = CIFilter.stripesGenerator()
    filter.color0 = CIColor(color: colors.0)
    filter.color1 = CIColor(color: colors.1)
    filter.width = Float(width-width*ratio)
    filter.center = CGPoint(x: width, y: 0)
    let size = CGSize(width: width+width*ratio, height: 1)
    let bounds = CGRect(origin: .zero, size: size)
    // keep a reference to a CIContext if calling this often
    return CIContext().createCGImage(filter.outputImage!.clamped(to: bounds), from: bounds)!
  }
}
