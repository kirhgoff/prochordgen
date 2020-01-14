//
//  main.swift
//  prochordgen
//
//  Created by Kirill Lastovirya on 13/1/20.
//  Copyright © 2020 Kirill Lastovirya. All rights reserved.
//

import Foundation

print("---------------------------------")
print("Progressive chords generator v1.0")
print("---------------------------------")

let sampleChords = ["A", "A#dim7", "A6", "Bm/E", "Bm7", "C#7", "C#m", "D", "E", "E/G#", "E7", "E7b9", "F", "F#7", "F#9", "F#m", "F#m/A", "G9"]

for chordString in sampleChords {
    let chord = ChordParser.parse(text: chordString)
    print("\(chordString)\t\(chord!)")
}
