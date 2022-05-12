//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI
//allows us to not repeat animation code in body
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct ContentView: View {
    @Environment(\._accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    var body: some View {
        Text("Hello World")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale += 1.5
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
