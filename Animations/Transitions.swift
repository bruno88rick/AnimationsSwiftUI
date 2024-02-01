//
//  Transitions.swift
//  Animations
//
//  Created by Bruno Oliveira on 01/02/24.
//

import SwiftUI

struct Transitions: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    //adding a transition modifiers to a rectangle view so we can scale up and down the hidden animation. Transitions just make sense with an animation appliied...
                    /*.transition(.scale)*/
                    // we can use .asymmetric on transitions modifier to apply different transitions whe the view shows up and dissapear, like this:
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        
    }
}

#Preview {
    Transitions()
}
