//
//  ContentView.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/9/22.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * -5, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    @State private var cards = [Card]()
    //timer
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //checking app status (background, active)
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    //for voice over
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    //adding cards
    @State private var showingEditScreen = false
    //for checking correctness
    @State private var isCorrect = true
    
    //for saving to disc
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card, isCorrect: $isCorrect) {
                            withAnimation {
                                removeCard()
                            }
                        }
                        .stacked(at: cards.firstIndex(of: card)!, in: cards.count)
                        //disables swiping cards that are not on top
                        .allowsHitTesting(card == cards.last)
                        //ignores below cards for voice over
                        .accessibilityHidden(card != cards.last)
                    }
                }
                //prohibits swipe after time is 0
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Restart", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            //show buttons when user has accessibility needs
            if diffWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        //changed images to Buttons for voice over purposes
                        Button {
                            withAnimation {
                                removeCard()
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard()
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        //only works since EditCards initializer has no values being passed in
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            //no saved data
            cards = []
        }
    }
    
    func removeCard() {
        guard cards.count >= 0 else { return }
        var tempCard = cards.removeLast()
        print("Removing")
        if isCorrect == false {
            print("Wrong")
            tempCard.id = UUID()
            cards.insert(tempCard, at: 0)
            isCorrect = true
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        loadData()
        timeRemaining = 100
        isActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
