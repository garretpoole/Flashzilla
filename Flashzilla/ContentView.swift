//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle Tapped")
                }
            //same frame but only 'taps' when touch circle itself
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                //makes entire frame count as tap area
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle Tapped")
                }
                //tap on circle is ignored
//                .allowsHitTesting(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
