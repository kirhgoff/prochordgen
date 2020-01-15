//
//  Tests.swift
//  Tests
//
//  Created by Kirill Lastovirya on 13/1/20.
//  Copyright © 2020 Kirill Lastovirya. All rights reserved.
//

import XCTest

@testable import prochordgen

class ChordParserTests: XCTestCase {

    func testKeyNote() {
        let chord = ChordParser.parse(text: "Dbdim7")
        XCTAssertEqual(chord?.keyNote.name, "Db")
    }
}
