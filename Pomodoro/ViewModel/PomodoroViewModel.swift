//
//  PomodoroViewModel.swift
//  Pomodoro
//
//  Created by Pang Yen Wu on 12/17/22.
//
import SwiftUI

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var isTicking = false
        @Published var time: String = "25:00"
        @Published var minutes: Float = 25.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        private var initialTime = 0
        private var countDownTime = Date()
        
        func updateCountdown() {
            guard isTicking else { return }
            
            let now = Date()
            let timeRemaining = countDownTime.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if timeRemaining <= 0 {
                
                self.isTicking = false
                self.time = "0.00"
                return
            }
            
            let date = Date(timeIntervalSince1970: timeRemaining)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.minutes = Float(minutes)
            self.time = String(format: "%d:%02d", minutes, seconds)
        }
        
        func countDownStart(minutes: Float) {
            self.initialTime = Int(minutes)
            self.countDownTime = Date()
            self.isTicking = true
            self.countDownTime = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: countDownTime)!
        }
    }
}



