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

    static func makeFor(_ key: String?) -> Note? {
        if let key = key, let position = majorScale[key] {
            return Note(name: key, positionOnScale: position)
        }
        return nil
    }

    var description: String {
        return "Note [\(name), \(positionOnScale)]"
    }
}

enum ChordType {
    case major
    case minor
    case majorSeventh
    case minorSeventh
    case dominantSeventh
    case diminished
    case sixth
    case ninth
    case unknown(text: String?)
    // Add all of them...

    static func forString(_ type: String?) -> ChordType {
        switch type {
        case "m": return .minor
        case "maj": return .major
        case nil: return .major
        case "": return .major
        case "6": return .sixth
        case "m7": return .minorSeventh
        case "maj7": return .majorSeventh
        case "M7": return .majorSeventh
        case "7": return .dominantSeventh
        case "dim7": return .diminished
        case "9": return .ninth
        default: return .unknown(text: type)
        }
    }
}

class Chord : CustomStringConvertible {
    let keyNote: Note
    let type: ChordType

    init(key keyNote: Note, type: ChordType) {
        self.keyNote = keyNote
        self.type = type
    }

    var description: String {
        return "Chord [\(keyNote) \(type)]"
    }
}

class ChordParser {
    static let FULL_CHORD_REGEX =
        "(?<chord>[ABCDEFG](?:b|#)*)(?<type>(?:m)*(?:[769]|dim|sus2|sus4)*)(?<amendment>(?:b|#)*(?:[569]*))"

    static func parse(text chordString: String) -> Chord? {
        func extractPart(from result: NSTextCheckingResult?, at name: String) -> String? {
            if let range = result?.range(withName: name), range.location != NSNotFound {
                return (chordString as NSString).substring(with: range)
            }
            return nil
        }

        let regex = try! NSRegularExpression(pattern: FULL_CHORD_REGEX)
        let range = NSRange(location: 0, length: chordString.count)
        let result = regex.firstMatch(in: chordString, options: [], range: range)

        let chordKey = extractPart(from: result, at: "chord")
        let type = extractPart(from: result, at: "type")
        //let amendment = extractPart(from: result, at: "amendment")

        return Chord(key: Note.makeFor(chordKey)!, type: ChordType.forString(type))
    }
}
