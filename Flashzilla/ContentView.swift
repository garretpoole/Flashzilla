//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        Text("hello world")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                //in app
                if newPhase == .active {
                    print("Active")
                //if can be seen but not interactable
                } else if newPhase == .inactive {
                    print("Inactive")
                //cannot be seen by user (home screen)
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
