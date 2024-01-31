//
//  AnimatingGestures.swift
//  Animations
//
//  Created by Bruno Oliveira on 31/01/24.
//

import SwiftUI

struct AnimatingGestures: View {
    @State private var dragAmount = CGSize.zero //CGSize, "Core Grafics Size" é uma estrutura que representa um tamanho em um espaço bidimensional, ou seja, tem uma largura e uma altura. CGSize.zero é basicamente um atalho para CGSize(width: 0, height: 0). Então, quando você inicia dragAmount com CGSize.zero, você está dizendo que o valor inicial para o arraste é zero tanto na largura quanto na altura. É uma estrutura definida no framework Core Graphics da Apple, usada principalmente no desenvolvimento para iOS e macOS. Ela representa um tamanho em um espaço 2D, com valores para largura (width) e altura (height) ou x e y. É uma parte fundamental da criação de interfaces de usuário e manipulação de gráficos em aplicativos Apple.
    
    //to letter animations:
    @State private var enabled = false
    @State private var dragAmount1 = CGSize.zero
    let letters = Array("Hello SwiftUI!") //create an array of this letters
    
    var body: some View {
        VStack{
            LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .cornerRadius(10)
                //implicit animation to animate the role thing (onChanged and onEnded) .bouncy is a built-in swiftUI animation that produce spring with gentle bounce anmation
                /*.animation(.bouncy, value: dragAmount)*/
        }
        //a card that we can drag around the screen, but when we let go it snapps back into its original location
        .offset(dragAmount) /*você está alterando a posição dessa view na tela. O valor de dragAmount é do tipo CGSize, o que significa que ele tem componentes de largura (width) e altura (height).
        
        •    Se dragAmount.width for positivo, a view será movida para a direita. Se for negativo, a view será movida para a esquerda.
        •    Se dragAmount.height for positivo, a view será movida para baixo. Se for negativo, a view será movida para cima.

    É importante notar que esse deslocamento é relativo à posição original da view. Então, se dragAmount for (20, 30), a view será movida 20 pontos para a direita e 30 pontos para baixo.

    Este modificador é muito útil para criar interações dinâmicas em suas interfaces de usuário. Por exemplo, você pode usá-lo para arrastar uma view, fazer animações, ou responder a gestos de arrasto do usuário. No contexto de desenvolvimento mobile com SwiftUI, explorar modificações como .offset pode abrir muitas possibilidades para interfaces de usuário interativas e atraentes.*/
        
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation } // translation parameter will describe drag operation - where it is currently, how far it moved and so on. For onChannged modifiers we're goig to read the translation (traduçao) off the drag, wih tell us how far ts moved from the star point and we can  assign that directly t dragAmount so that ower view moves along with the gesture
                .onEnded { _ in
                    //explicity animation to apply movement only on back to initial position view
                    withAnimation(.bouncy) {
                        dragAmount = .zero // here we ignoe translation and set dragAmount back to y:0 and x: 0
                    }
                }
        )
     
        /*If we combine offset animations with drag gestures and a little delay, we can create remarkably fun animations without a lot of code.
        
        To demonstrate this, we could write the text “Hello SwiftUI” as a series of individual letters, each one with a background color and offset that is controlled by some state. Strings are just slightly fancy arrays of characters, so we can get a real array from a string like this: Array("Hello SwiftUI").*/
        .padding(100)
        
        Spacer(minLength: 10)
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount1)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount1 = $0.translation }
                .onEnded { _ in
                    dragAmount1 = .zero
                    enabled.toggle()
                }
        )
        Spacer()
    }
}

#Preview {
    AnimatingGestures()
}
