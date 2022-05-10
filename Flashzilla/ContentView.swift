//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        
        
        VStack {
            //child gesture is given priority by default
            Text("Hello, world!")
                .onTapGesture {
                    print("Text Tapped")
                }
                
        }
//        .onTapGesture {
//            print("VStack Tapped")
        //overrides default child priority
//        .highPriorityGesture(
        //makes gestures work together (no override)
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack Tapped")
                }
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
