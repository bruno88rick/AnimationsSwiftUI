//
//  AnimatingBindings.swift
//  Animations
//
//  Created by Bruno Oliveira on 31/01/24.
//

import SwiftUI

struct AnimatingBindings: View {
    
    @State private var animatedBoolean = false
    @State private var animatedAmount = 1.0
    
    var body: some View {
        // we can animate anithing in SwiftUI, the animation modifier can be applied to ay swiftUI biindind, which causes the value to animate between its currennt and new values. Even if the data in question isn't really something that sounds like it can be animated, such as Boolean.
        print(animatedAmount)
        print(animatedBoolean)
        
       //when we use in the body clousure things that is not conformin to View protocol like "print" we need to add the return before the view so Swift will understand which part is the view that is being sent back:
        
       return VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            VStack(spacing: 100) {
                Stepper("Scale Button: ", value: $animatedAmount.animation(
                    .easeInOut(duration: 2)
                    .repeatCount(3, autoreverses: true)), in: 0...10, step: 0.5)
                Button("Tap Me") {
                    animatedAmount += 0.5
                }
                .frame(width: 100, height: 50, alignment: .center)
                .padding(40)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 20))
                .scaleEffect(animatedAmount)
            }
            .padding(20)
            Spacer()
            
            VStack(spacing: 20) {
                Button("Tap Me too") {
                    animatedBoolean.toggle()
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50, alignment: animatedBoolean ? .bottomTrailing : .center)
                .padding(40)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(.circle)
                .scaleEffect(animatedAmount)
                .animation(.linear(duration: 1))
            }
        }
    }
}

#Preview {
    AnimatingBindings()
}
