//
//  ContentView.swift
//  Pomodoro
//
//  Created by Pang Yen Wu on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    
    private var countDownStartTime: String = "25:00"
   @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        VStack {
            Text("Time: \(viewModel.time)")
                .padding(.top, 200)
                .padding(.bottom, 100)
            Button("Start") {
                viewModel.countDownStart(minutes: viewModel.minutes)
            }
            .disabled(viewModel.isTicking)
            
            Button {
                timer.upstream.connect().cancel()
                
            } label: {
                Label("Stop", systemImage: "nosign")
            }
            .buttonStyle(.bordered)
            
            Button {
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            } label: {
                Label("Resume", systemImage: "play")
            }
            .buttonStyle(.borderedProminent)
        }
        .onReceive(timer) { _ in
            viewModel.updateCountdown()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
