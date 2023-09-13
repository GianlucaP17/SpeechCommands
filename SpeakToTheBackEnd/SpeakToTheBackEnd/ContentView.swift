//
//  ContentView.swift
//  SpeakToTheBackEnd
//
//  Created by Gianluca Posca on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm : ViewModel = ViewModel()
    @State var newCommandTf : String = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("\("Current Commands available".localized): \(vm.commandsKeywords.joined(separator: ", "))")
                    .font(.body)
                    .padding()
                
                HStack {
                    TextField("Enter a new command".localized, text: $newCommandTf)
                    Button("Add".localized) {
                        vm.enterNewCommand(command: newCommandTf)
                        newCommandTf = ""
                    }
                }.padding()
                
                
                Text("\("Current State".localized): \(vm.currentState.rawValue.localized)")
                    .font(.headline)
                    .padding()
                
                Text("Speech detection:".localized)
                    .font(.headline)
                    .padding(5)
                
                Text(vm.stringArray.last ?? "")
                    .font(.body)
                    .padding()
                
                ScrollView {
                    ForEach(vm.commandOutputs, id: \.id) { string in
                        Text(string.id == vm.commandOutputs.first?.id  ? "Current Command:".localized : "Last Commands:".localized)
                        Text("\("Command".localized): " + (string.command) + "\n\("Parameters".localized): " + (string.value ?? ""))
                            .font(.body)
                            .padding(10)
                            .background(Color.gray)
                    }
                }
                
                Button(action: {
                    vm.isRecording ? vm.stopRecording() : vm.startRecording()
                    vm.isRecording.toggle()
                }) {
                    Text(vm.isRecording ? "Stop recognition".localized : "Start recognition".localized)
                        .padding()
                }
                
                Button("Send to BE".localized) {
                    vm.sendDataToBE()
                }.padding()
            }
            
            if vm.successAlert || vm.errorAlert {
                ScreenAlert(text: "Test: An unknown error occur, try again later", show: vm.errorAlert, color: Color.red)
                ScreenAlert(text: vm.dataToBE, show: vm.successAlert, color: Color.green).onTapGesture {
                    vm.successAlert.toggle()
                }
            }
        }
       
    }
    
    struct ScreenAlert: View {
        var text: String
        var show: Bool
        var color: Color
        
        var body: some View {
            ScrollView {
                Text(text)
                    .padding(20)
                    .background(color)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(color: Color.gray, radius: 5, x: 0, y: 5)
                    .opacity(show ? 1 : 0)
                    .padding()
                    .padding(.top, 50)
            }
           
        }
    }
    
}
