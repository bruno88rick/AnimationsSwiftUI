//
//  AnimationStack.swift
//  Animations
//
//  Created by Bruno Oliveira on 31/01/24.
//

import SwiftUI

struct AnimationStack: View {
    
    @State private var enabled = false
    
    var body: some View {
        
        // modifiers other metter, and because of this, we can create multiple animations too:
        VStack (spacing: 100 ) {
            Button("Tap me!") {
                
            }
            .background(.blue)
            .frame(width: 200, height: 200)
            .foregroundColor(.white)
         
            Button("Tap me!") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .foregroundColor(.white)
            .animation(.default, value: enabled)
            .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
            //because of order of modifiers and anumations metters, we can use different animations to apply on the same view
            .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
            .blur(radius: enabled ? 3.0 : 0)
            // we can disable animations entirely by pssing nil to the modifiers. We want the blur occurs immediately and the others retain its animation
            .animation(enabled ? nil : .default, value: enabled)
            
            //That kind of control wouldn’t be possible without multiple animation() modifiers – if you tried to move background() after the animation you’d find that it would just undo the work of clipShape()
        }
    }
}

#Preview {
    AnimationStack()
}
