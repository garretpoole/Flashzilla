//
//  Card.swift
//  Flashzilla
//
//  Created by Garret Poole on 5/12/22.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who is SF Giants shortstop", answer: "Brandon Crawford")
}
