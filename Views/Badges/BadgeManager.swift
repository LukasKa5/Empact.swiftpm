import Foundation

class BadgeManager {
    
    static func checkAndUnlockBadges(for category: String, completedChallenges: Int) {
        var unlockedBadges = UserDefaults.standard.dictionary(forKey: "unlockedBadges") as? [String: Bool] ?? [:]

        let badgeThresholds: [String: [(count: Int, badgeName: String)]] = [
            "Self-Care": [(1, "Self-Care Guru"), (10, "Empact Fanatic"), (100, "Self-Improver")],
            "Environment": [(1, "Green Guardian"), (10, "Earth Defender"), (100, "Captain Planet 2.0")],
            "Community": [(1, "High-Five Hero"), (10, "Happiness Distributor"), (100, "The People's Champion")]
        ]

        if let categoryBadges = badgeThresholds[category] {
            for (count, badgeName) in categoryBadges {
                if completedChallenges >= count && unlockedBadges[badgeName]
                    != true {
                    unlockedBadges[badgeName] = true
                }
            }
        }

        UserDefaults.standard.set(unlockedBadges, forKey: "unlockedBadges")
    }
    
    static func getUnlockedBadges() -> [String: Bool] {
        return UserDefaults.standard.dictionary(forKey: "unlockedBadges") as? [String: Bool] ?? [:]
    }
}
