//
//  ChordParser.swift
//  prochordgen
//
//  Created by Kirill Lastovirya on 13/1/20.
//  Copyright © 2020 Kirill Lastovirya. All rights reserved.
//

import Foundation

class Note : CustomStringConvertible {
    private static let majorScale = [
        "C" : 0,
        "C#": 1,
        "Db": 1,
        "D" : 2,
        "D#": 3,
        "Eb": 3,
        "E" : 4,
        "F" : 5,
        "F#": 6,
        "Gb": 6,
        "G" : 7,
        "G#": 8,
        "Ab": 9,
        "A" : 10,
        "A#": 11,
        "Bb": 11,
        "B" : 12
    ]

    let name: String
    let positionOnScale: Int

    private init(name: String, positionOnScale: Int) {
        self.name = name;
        self.positionOnScale = positionOnScale
    }

    static func makeFor(_ key: String) -> Note? {
        if let position = majorScale[key] {
            return Note(name: key, positionOnScale: position)
        }
        return nil
    }

    var description: String {
        return "Note [\(name), \(positionOnScale)]"
    }
}

class Chord : CustomStringConvertible {
    let keyNote: Note

    init(_ keyNote: Note) {
        self.keyNote = keyNote
    }

    var description: String {
        return "Chord [key: \(keyNote)]"
    }
}

class ChordParser {
    static let REGEX_KEY = "[ABCDEFG](b|#)*"

    static func parse(text chordString: String) -> Chord? {
        let range = NSRange(location: 0, length: chordString.utf16.count) // or take 2
        let regex = try! NSRegularExpression(pattern: REGEX_KEY)

        // TODO: fix that shit
        let results = regex.matches(in: chordString, range: range)
        let key: String = results.map { String(chordString[Range($0.range, in: chordString)!]) } [0]

        return Chord(Note.makeFor(key)!)
    }
}
