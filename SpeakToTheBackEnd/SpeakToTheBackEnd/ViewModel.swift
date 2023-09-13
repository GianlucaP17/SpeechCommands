//
//  ViewModel.swift
//  SpeakToTheBackEnd
//
//  Created by Gianluca Posca on 13/09/23.
//

import Speech
import AVFoundation

class ViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var currentState: RecordState = .waiting
    @Published var stringArray : [String] = []
    @Published var commandOutputs: [VoiceCommand] = []
    @Published var commandsKeywords : [String]  = ["code".localized, "count".localized, "reset".localized, "back".localized]
    @Published var commandsResetKeywords : [String]  = ["ripristina".localized, "indietro".localized]
    @Published var errorAlert : Bool = false
    @Published var dataToBE : String = ""
    @Published var successAlert : Bool = false
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.current)
    let audioEngine = AVAudioEngine()
    
    func enterNewCommand(command: String) {
        commandsKeywords.append(command)
    }
    
    func sendDataToBE() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try encoder.encode(commandOutputs)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                dataToBE = jsonString
                successAlert.toggle()
            }
        } catch {
            errorAlert.toggle()
        }
    }
    
    func startRecording() {
        let request = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        self.currentState = .waiting
        
        guard let _ = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let resultText = result.bestTranscription.formattedString
                let result = self.splitByKeywords(resultText)
                
                self.stringArray = result.text
                self.commandOutputs = result.commands
            } else if let error = error {
                print("error during speech recognition: \(error)")
            }
        }) else { return }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("error during audioEngine boot: \(error)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        self.currentState = .waiting
    }
    
    func splitByKeywords(_ text: String) -> (text: [String], commands: [VoiceCommand]) {
        var result: [String] = []
        var currentPhrase = ""
        
        var commandResult: [VoiceCommand] = []
        var command = VoiceCommand(command: "", value: "")
        
        for word in text.lowercased().components(separatedBy: " ") {
            if commandsResetKeywords.contains(word) {
                currentPhrase = ""
                command = VoiceCommand(command: word, value: "")
                commandResult.insert(command, at: 0)
                self.currentState = .waiting
            } else if commandsKeywords.contains(word) {
                if !currentPhrase.isEmpty {
                    result.append(currentPhrase)
                    commandResult.insert(command, at: 0)
                }
                currentPhrase = word
                command = VoiceCommand(command: word, value: "")
                self.currentState = .listening
            } else {
                if commandsKeywords.contains(currentPhrase.components(separatedBy: " ").first ?? "") {
                    if let _ = Int(word) {
                        command.value = (command.value ?? "") + word
                        currentPhrase += " " + NumberFormatHelper().numberDivider(word: word)
                    }
                }
            }
        }
        
        if !currentPhrase.isEmpty {
            result.append(currentPhrase)
            commandResult.insert(command, at: 0)
        }

        return (text: result, commands: commandResult)
    }
}
