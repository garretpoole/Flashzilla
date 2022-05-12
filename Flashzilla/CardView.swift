//
//  CardView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/12/22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var showingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if showingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        //means fully visible no matter the iphone
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width*0.2)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        //remove card
                        removal?()
                        
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            showingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
