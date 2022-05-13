//
//  Card.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/12/22.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who is SF Giants shortstop", answer: "Brandon Crawford")
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id && lhs.prompt == rhs.prompt
    }
}
