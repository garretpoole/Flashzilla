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
    @Environment(\._accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("Hello World")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
