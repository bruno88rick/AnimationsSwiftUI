//
//  ExplicitAnimation.swift
//  Animations
//
//  Created by Bruno Oliveira on 31/01/24.
//

import SwiftUI

struct ExplicitAnimation: View {
    
    @State private var animationAmount = 0.0
    @State private var animationAmount1 = 0.0
    
    var body: some View {
        Button("Tap Me") {
            
            //If we just write animationAmount += 360 then the change will happen immediately, because there is no animation modifier attached to the button. This is where explicit animations come in: if we use the withAnimation() function then SwiftUI will ensure any changes resulting from the new state will automatically be animated.
            
            withAnimation(){
                animationAmount += 180
            }
            
            //withAnimation() can be given an animation parameter, using all the same animations you can use elsewhere in SwiftUI. For example, we could make our rotation effect use a spring animation using a withAnimation() call like this:
            
            withAnimation(.spring(duration: 1, bounce: 0.9, blendDuration: 1)){
                animationAmount1 += 360
            }
            
            //Change the value on .degrees between animationAmount and animationAmount1 to see the diferent animations.
        
        }
        .padding(40)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount1), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    ExplicitAnimation()
}
