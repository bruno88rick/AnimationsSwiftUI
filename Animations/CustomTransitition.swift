//
//  CustomTransitition.swift
//  Animations
//
//  Created by Bruno Oliveira on 01/02/24.
//

import SwiftUI

//we can create custom transitions, allowing us to add and remove views using entirely custom animations, like this:
/*
 
 using .modifier transition, wich accepts any view modifier we want
 using rotationEffect() lets us rotate aa view in 2D space, similar to rotation3DEffect(), but without the Z point and gives us the ability too control the anchor point of rotation, Swift give us the UnitPoint type for controlling the anchor, specifyinng as exact x/y point for the rotation or use the many built in options .topLeading, .bootomTrainling, .center, and so on.
 using clipped() to stops the view from being  drawn outside of its rectangular space.
 
 */


// lets create a struct that has an anchor point to control where the rotation should take place, and an amount to control how much rotation should be applied
struct CornerRotateModifier: ViewModifier {
    
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View{
        content
            //rotation effect modifers, that accept an amount degrees to rotate and an anchor fixed to ratate
            .rotationEffect(.degrees(amount), anchor: anchor)
            //clipped modifierr to stops the view from being drawn outside its space (try commenting this line to see the diferences) -> there means that when the view rotates the parts that are lying outside its natural rectangle don’t get drawn
            .clipped()
    }
    
}

//unwrap all that struct on an extention of the AnyTransition struct to facilitate the use and applying on a .modifier. With this we can attach the pivot animation to any view using .transition(.pivot)

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct CustomTransitition: View {
    
    //we can use the onTapGesture() modifier to make a red rectangle pivot onto the screen
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
                
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            } /*else {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .opacity, removal: .pivot))
            }*/
        }
        .onTapGesture {
            withAnimation(.spring(duration: 1, bounce: 0.6, blendDuration: 1)) {
                isShowingRed.toggle()
            }
        }
    }
}

#Preview {
    CustomTransitition()
}
