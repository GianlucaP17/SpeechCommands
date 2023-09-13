//
//  Localizable.swift
//  SpeakToTheBackEnd
//
//  Created by Gianluca Posca on 13/09/23.
//

import Foundation

protocol Localizable {
    var localized: String { get }
    func localizedFormat(withArguments args: CVarArg...) -> String
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedFormat(withArguments args: CVarArg...) -> String {
        return String(format: self.localized, arguments: args)
    }
}
