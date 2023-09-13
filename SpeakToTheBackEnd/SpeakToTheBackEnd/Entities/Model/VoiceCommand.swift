//
//  VoiceCommand.swift
//  SpeakToTheBackEnd
//
//  Created by Gianluca Posca on 13/09/23.
//

import Foundation

struct VoiceCommand: Encodable {
    var id = UUID().uuidString
    var command: String
    var value: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(command, forKey: .command)
        try container.encode(value, forKey: .value)
    }
    
    enum CodingKeys: String, CodingKey {
        case command
        case value
    }
}
