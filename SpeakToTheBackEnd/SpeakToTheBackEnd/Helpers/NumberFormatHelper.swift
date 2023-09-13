//
//  NumberFormatHelper.swift
//  SpeakToTheBackEnd
//
//  Created by Gianluca Posca on 13/09/23.
//

import Foundation

class NumberFormatHelper {
    func numberDivider(word: String) -> String {
        let res = word.compactMap{ $0.wholeNumberValue }
        let prova = res.compactMap{"\(numberToSpell($0)) "}
        return prova.joined()
    }

    func numberToSpell(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(for: number) ?? ""
    }
}


