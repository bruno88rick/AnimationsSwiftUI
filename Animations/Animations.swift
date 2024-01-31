//
//  ContentView.swift
//  Animations
//
//  Created by Bruno Oliveira on 31/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var animationAmount1 = 1.0
    
    var body: some View {
        VStack(alignment: .center) {
            VStack() {
                Button("Tap me") {
                    animationAmount += 0.2
                }
                .padding(50)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(.rect(cornerRadius: 20, style: .circular))
                //using the modifier called "scaleEffect()" to increase the size of the button every time it's pressed.
                .scaleEffect(animationAmount)
                .blur(radius: (animationAmount - 1) * 3) // A radius of (animationAmount - 1) * 3 means the blur radius will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.
                //adding the "animation() modifier to apply a smoth inscrease, in this case a default animation, while the button gets bigger". This inplicit animation takes effect on all properties of the view that change.
                .animation(.default, value: animationAmount)
                //meaning that if we attach more animating modifiers to the view then they will all change together. For exemple we can add a 2º modifier to a button like blur, which lets us add a Gaussian blur with a special radius – like the modifier added before the animation() modifier. Coment that line and see the dference.
            }
            .padding()
        }
        .padding(80)
        VStack(){
            Button("Tap me too!") {
                //animationAmount1 += 0.5 - to try the overlay this line must be commented, to try other animations discoment this line
            }
            .padding(50)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(.circle)
            //.scaleEffect(animationAmount1) - to try the overlay this line must be commented, to try other animations discoment this line
            .onAppear{ // this code is used to demonstrate the overlay effect with animation, to try others effects, coment this line and dismoment line above
                animationAmount1 = 2
            }
            
            //When we attach the animation() modifier to a view, SwiftUI will automatically animate any changes that happen to that view using whatever is the default system animation, whenever the value we’re watching changes. In practice, that is a very gentle spring, which means iOS will start the animation slow, then make it pick up speed until it ever-so-slightly overshoots the target value, then it will end by going backwards just a touch until it reaches its end state. We can control the type of animation used by passing in different values to the modifier. For example, we could use .linear to make the animation move at a constant speed from start to finish:
            /*.animation(.linear, value: animationAmount1)*/
            
            //iOS chooses spring animations by default because they mimic what we're used to in the real world. These are hugely customizable: you can control roughly how long the spring should take to complete, and also how bouncy the spring should – whether it should bounce back and forwards more or less, where 1 is maximum bounciness and 0 is no bounciness. For example, this makes our button scale up quickly then bounce a lot:
            /*.animation(.spring(duration: 1, bounce: 0.9), value: animationAmount1)*/
            
            //For more precise control, we can customize the animation with a duration specified as a number of seconds. So, we could get an ease-in-out animation that lasts for two seconds like this:
            /*.animation(.easeInOut(duration: 2), value: animationAmount1)*/
            
            //When we say .easeInOut(duration: 2) we’re actually creating an instance of an Animation struct that has its own set of modifiers. So, we can attach modifiers directly to the animation to add a delay like this: With that in place, tapping the button will now wait for a second before executing a two-second animation.
            /*.animation(
                .easeInOut(duration: 2)
                    .delay(1),
                value: animationAmount1
            )*/
            
            //We can also ask the animation to repeat a certain number of times, and even make it bounce back and forward by setting autoreverses to true. This creates a one-second animation that will bounce up and down before reaching its final size. If we had set repeat count to 2 then the button would scale up then down again, then jump immediately back up to its larger scale. This is because ultimately the button must match the state of our program, regardless of what animations we apply – when the animation finishes the button must have whatever value is set in animationAmount.
            /*.animation(
                .easeInOut(duration: 2)
                    .repeatCount(3, autoreverses: true),
                value: animationAmount1
            )*/
            
            //for continuous anumation, there is a repeatForever() modifier:
            /*.animation(
                .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                value: animationAmount1
            )*/
            
            //If we had set repeat count to 2 then the button would scale up then down again, then jump immediately back up to its larger scale. This is because ultimately the button must match the state of our program, regardless of what animations we apply – when the animation finishes the button must have whatever value is set in animationAmount. That makes a stroke green cicle over our button, using an opacity value of 2 - animationAmount so that when animationAmount is 1 the opacity is 1 (it's opaque) and when animationAmount is 2 the opacity is 0 (its transparent).
            .overlay(
            Circle()
                .stroke(.green)
                .scaleEffect(animationAmount1)
                .opacity(2 - animationAmount1)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false), // because of overlay circles uses that for a "repeat foverver" animation without autoreversing, you'll see the overlay circle scale up and fade out continuously
                    value: animationAmount1
                )
            )
            
            
        }
    }
}

#Preview {
    ContentView()
}
