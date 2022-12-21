//
//  ContentView.swift
//  Pomodoro
//
//  Created by Pang Yen Wu on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State var isTimerStarted = false
    @State var timeDuration = 1500
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            VStack {
                Text("\(self.timeDuration, specifier: formatTime() )")
            }
        
            HStack(spacing:20) {
                Button(action: {
                    if self.timeDuration > 0 {
                        self.isTimerStarted.toggle()
                    }
                }){
                    HStack(spacing: 15) {
                        Text(!self.isTimerStarted ? "Start" : "Pause")
                            .foregroundColor(self.isTimerStarted ? .red : .green)
                    }
                }
            }
        .onReceive(self.time, perform: { _ in
            if self.isTimerStarted {
                if self.timeDuration != 0 {
                    self.timeDuration -= 1
                }
                
                if self.timeDuration == 0 {
                    self.isTimerStarted = false
                    self.timeDuration = 1500
                }
             }
        })
    }
    
    func formatTime() -> String {
        let minutes = Int(timeDuration) / 60 % 60
        let seconds = Int(timeDuration) % 60
        return String(format: "%02i:%02i", minutes,seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
