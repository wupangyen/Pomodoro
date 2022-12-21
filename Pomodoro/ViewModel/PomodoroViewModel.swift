//
//  PomodoroViewModel.swift
//  Pomodoro
//
//  Created by Pang Yen Wu on 12/17/22.
//
import SwiftUI

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var isTimerStarted = false
        @Published var timeDuration = 1500

    }
}

 

