//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\._accessibilityDifferentiateWithoutColor) var diffWithoutColor
    @Environment(\._accessibilityReduceMotion) var reduceMotion
    var body: some View {
        HStack {
            if diffWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(diffWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
