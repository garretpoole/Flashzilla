//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    var body: some View {
        Text("Hello, world!")
//            .onTapGesture(count: 2) {
//                print("Double Tapped")
//            }
//            .onLongPressGesture(minimumDuration: 1) {
//                print("Long Press")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)")
//            }
        
//            .scaleEffect(finalAmount + currentAmount)
            .rotationEffect(finalAmount + currentAmount)
            .gesture(
//                MagnificationGesture()
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onEnded { angle in
                        finalAmount +=  currentAmount
                        currentAmount = .zero
                    }
            )
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
