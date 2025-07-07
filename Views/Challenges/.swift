//
//  ChallengeStore.swift
//  Empact
//
//  Created by Martin Kaniansky on 08.02.2025.
//


import SwiftUI

class ChallengeStore: ObservableObject {
    @Published var selectedChallenges: [Challenge] = [] {
        didSet {
            saveChallenges()
        }
    }

    init() {
        loadChallenges()
    }

    // Save challenges to UserDefaults
    func saveChallenges() {
        if let encoded = try? JSONEncoder().encode(selectedChallenges) {
            UserDefaults.standard.set(encoded, forKey: "savedChallenges")
        }
    }

    // Load challenges from UserDefaults
    func loadChallenges() {
        if let savedData = UserDefaults.standard.data(forKey: "savedChallenges"),
           let decodedChallenges = try? JSONDecoder().decode([Challenge].self, from: savedData) {
            self.selectedChallenges = decodedChallenges
        } else {
            self.selectedChallenges = ChallengeStore.defaultChallenges // Load default
        }
    }

    static let defaultChallenges: [Challenge] = [
        Challenge(name: "Help a neighbor", category: "Community", time: "30 min", empactScore: 10),
        Challenge(name: "Recycle old paper", category: "Environment", time: "15 min", empactScore: 5),
        Challenge(name: "Donate old clothes", category: "Charity", time: "1 hour", empactScore: 20)
    ]
}
