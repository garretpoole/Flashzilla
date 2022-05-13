//
//  Card.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/12/22.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String
    let index: Int
    
    static let example = Card(prompt: "Who is SF Giants shortstop", answer: "Brandon Crawford", index: 0)
}
