import SwiftUI

struct BadgesView: View {
    @State private var selectedBadge: Badge?
    @State private var unlockedBadges = BadgeManager.getUnlockedBadges()

    var selfCareBadges: [Badge] {
        return [
            Badge(name: "Self-Care Guru", category: "Self-Care", imageName: "selfBadge2", isUnlocked: unlockedBadges["Self-Care Guru"] ?? false, description:  "Complete your first task in Self-Care category."),
            Badge(name: "Empact Fanatic", category: "Self-Care", imageName: "selfBadge", isUnlocked: unlockedBadges["Empact Fanatic"] ?? false, description: "Complete at least 10 tasks in Self-Care category."),
            Badge(name: "Self-Improver", category: "Self-Care", imageName: "selfBadge3", isUnlocked: unlockedBadges["Self-Improver"] ?? false, description: "Complete at least 100 tasks in Self-Care category.")
        ]
    }

    var environmentBadges: [Badge] {
        return [
            Badge(name: "Green Guardian", category: "Environment", imageName: "ecologyBadge", isUnlocked: unlockedBadges["Green Guardian"] ?? false, description: "Complete your first task in Environment category."),
            Badge(name: "Earth Defender", category: "Environment", imageName: "ecologyBadge2", isUnlocked: unlockedBadges["Earth Defender"] ?? false, description: "Complete at least 10 tasks in Environment category."),
            Badge(name: "Captain Planet 2.0", category: "Environment", imageName: "ecologyBadge3", isUnlocked: unlockedBadges["Captain Planet 2.0"] ?? false, description: "Complete at least 100 tasks in Environment category.")
        ]
    }

    var communityBadges: [Badge] {
        return [
            Badge(name: "High-Five Hero", category: "Community", imageName: "communityBadge2", isUnlocked: unlockedBadges["High-Five Hero"] ?? false, description: "Complete your first task in Community category."),
            Badge(name: "Happiness Distributor", category: "Community", imageName: "communityBadge", isUnlocked: unlockedBadges["Happiness Distributor"] ?? false, description: "Complete at least 10 tasks in Community category."),
            Badge(name: "The People's Champion", category: "Community", imageName: "communityBadge3", isUnlocked: unlockedBadges["The People's Champion"] ?? false, description: "Complete at least 100 tasks in Community category.")
        ]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                BadgeSectionView(title: "Self-Care", badges: selfCareBadges, selectedBadge: $selectedBadge)
                    .padding(.bottom, 10)
                
                BadgeSectionView(title: "Environment", badges: environmentBadges, selectedBadge: $selectedBadge)
                    .padding(.bottom, 10)
                
                BadgeSectionView(title: "Community", badges: communityBadges, selectedBadge: $selectedBadge)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .navigationTitle("Badges")
        .sheet(item: $selectedBadge) { badge in
            BadgeDetailView(badge: badge)
        }
        .onAppear {
            unlockedBadges = BadgeManager.getUnlockedBadges()
        }
    }
}





