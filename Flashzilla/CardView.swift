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
    
    //for red green color blindness
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    @State private var showingAnswer = false
    @State private var offset = CGSize.zero
    //haptic feedback
    @State private var feedback = UINotificationFeedbackGenerator()
    //voice over accessibility
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    diffWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    diffWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            
            VStack {
                //right when answer appears it is read
                if voiceOverEnabled {
                    Text(showingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if showingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        //means fully visible no matter the iphone
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width*0.2)))
        .offset(x: offset.width * 5, y: 0)
        //fade starts after 50 points away
        .opacity(2 - Double(abs(offset.width / 50)))
        //tells card can be tapped
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        //remove card
                        if offset.width < 0 {
                            //may want to think of overuse of haptics so no success haptic just on error
                            feedback.notificationOccurred(.error)
                        }
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            showingAnswer.toggle()
        }
        //animates the card "snapping" back
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
