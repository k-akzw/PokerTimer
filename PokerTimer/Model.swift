//
//  Model.swift
//  PokerTimer
//
//  Created by Kento Akazawa on 10/27/23.
//

import Foundation

class Model: NSObject, ObservableObject {

    // singleton instance of this class
    static let shared = Model()

    // list of big blinds
    // -1 represents break
    private let bigBlinds = [200, 400, 800, 1600, -1, 2000, 4000, 6000, 8000, -1, 10000, 12000, 16000, 20000]
    private let imageNames = ["", "yusei2", "", "", "", "", "", "", "", "", "", "", "", ""]

    private let chipChanges = [2000, 20000]

    // durations for each round in miniute
    private let durations = [5, 5, 5]

    private var timer: Timer? = nil

    @Published var timeText = ""
    @Published var bigBlind = 0
    @Published var isPaused = false
    @Published var isBreak = false
    @Published var chipChange = false
    @Published var imageName = ""
    private var timeRemaining = 0
    private var bigBlindIndex = 0
    private var durationIndex = 0
    private var endOfGame = false

    override init() {
        super.init()
        setup()
    }

    func restart() {
        setup()
    }

    private func setup() {
        bigBlindIndex = 0
        durationIndex = 0
        timeRemaining = durations[durationIndex]
        timeText = convertSecondsToTime(from: timeRemaining)
        bigBlind = bigBlinds[bigBlindIndex]
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.decrementTimer()
        }
    }

    private func decrementTimer() {
        if !endOfGame && !isBreak && !isPaused {
            timeText = convertSecondsToTime(from: timeRemaining)
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                endOfRound()
            }
        }
    }

    private func endOfRound() {
        bigBlindIndex += 1
        if bigBlindIndex >= bigBlinds.count - 1 {
            endOfGame = true
            timeText = "--:--"
        } else if bigBlinds[bigBlindIndex] == -1 {
            bigBlindIndex += 1
            durationIndex += 1
            isBreak = true
        }
        bigBlind = bigBlinds[bigBlindIndex]
        imageName = imageNames[bigBlindIndex]
        if chipChanges.contains(bigBlind) {
            chipChange = true
            let _ = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
                self.chipChange = false
            }
        }
        timeRemaining = durations[durationIndex]
    }

    private func convertSecondsToTime(from time : Int) -> String{
        let seconds = time % 60
        let min = time / 60
        var secondStr = String(seconds)
        if seconds < 10 {
            secondStr = "0" + secondStr
        }
        return "\(min):\(secondStr)"
    }
}
