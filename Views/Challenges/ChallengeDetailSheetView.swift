import SwiftUI
import Foundation

struct ChallengeDetailSheet: View {
    
    let challengeIndex: Int
    @Binding var empactScore: Int
    @Binding var isHappy: Bool
    @ObservedObject var store: ChallengeStore
    @ObservedObject var streakManager: StreakManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    dismiss() 
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            Text(store.selectedChallenges[challengeIndex].name)
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .padding(.top, 20)

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("Category: **\(store.selectedChallenges[challengeIndex].category)**")
                    .font(.title3)
                    .foregroundColor(.black)

                Text("Time: ⏳ **\(store.selectedChallenges[challengeIndex].time)**")
                    .font(.title3)
                    .foregroundColor(.black)

                Text("Empact score:🔥 **+ \(store.selectedChallenges[challengeIndex].empactScore) pts**")
                    .font(.title3)
                    .foregroundColor(.black)

                Divider()
                
                Text("Fun Fact: \(store.selectedChallenges[challengeIndex].funFact)")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)

            Spacer()

            HStack(spacing: 15) {
                Button(action: {
                    resetChallenge()
                }) {
                    Text("Get New Challenge")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: UIDevice.isIpad ? UIScreen.main.bounds.height * 0.03 : UIScreen.main.bounds.height * 0.07)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(25)
                }

                Button(action: {
                    completeChallenge()
                }) {
                    Text("Challenge Completed")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: UIDevice.isIpad ? UIScreen.main.bounds.height * 0.03 : UIScreen.main.bounds.height * 0.07)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(25)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color.white)
        .ignoresSafeArea()
    }

    private func resetChallenge() {
        if let newChallenge = store.getNewChallenge(excluding: store.selectedChallenges[challengeIndex]) {
            store.selectedChallenges[challengeIndex] = newChallenge
        }
    }

    private func completeChallenge() {
        
        let completedChallenge = store.selectedChallenges[challengeIndex]
        let challengeEmpactScore = completedChallenge.empactScore
        let category = completedChallenge.category

        empactScore += challengeEmpactScore
        UserDefaults.standard.set(empactScore, forKey: "empactScore")

        saveStatsEntry(empactScore: empactScore)

        let totalEmpactScore = UserDefaults.standard.integer(forKey: "totalEmpactScore") + challengeEmpactScore
        
        UserDefaults.standard.set(totalEmpactScore, forKey: "totalEmpactScore")

        let newPeopleHelped = UserDefaults.standard.integer(forKey: "peopleHelped") + completedChallenge.estPeopleHelped
        
        UserDefaults.standard.set(newPeopleHelped, forKey: "peopleHelped")

        let newGoodDeeds = UserDefaults.standard.integer(forKey: "goodDeedsCompleted") + 1
        
        UserDefaults.standard.set(newGoodDeeds, forKey: "goodDeedsCompleted")

        var categoryCompletionCounts = UserDefaults.standard.dictionary(forKey: "categoryCompletionCounts") as? [String: Int] ?? [:]
        categoryCompletionCounts[category, default: 0] += 1
        UserDefaults.standard.set(categoryCompletionCounts, forKey: "categoryCompletionCounts")

        BadgeManager.checkAndUnlockBadges(for: category, completedChallenges: categoryCompletionCounts[category] ?? 0)
        streakManager.updateStreak()
        
        resetChallenge()
        isHappy = true
        dismiss()
    }

    private func saveStatsEntry(empactScore: Int) {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: today)

        var stats: [String: StatsEntry] = [:]

        if let data = UserDefaults.standard.data(forKey: "statsHistory"),
           let decodedStats = try? JSONDecoder().decode([String: StatsEntry].self, from: data) {
            stats = decodedStats
        }

        stats[todayString] = StatsEntry(empactScore: empactScore)

        if let encodedStats = try? JSONEncoder().encode(stats) {
            UserDefaults.standard.set(encodedStats, forKey: "statsHistory")
        }
    }
}


class StreakManager: ObservableObject {
    @AppStorage("currentStreak") private var currentStreak: Int = 0
    @AppStorage("longestStreak") private var longestStreak: Int = 0
    @AppStorage("lastCompletedDate") private var lastCompletedDate: String = ""

    func updateStreak() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: today)

        if let lastDate = formatter.date(from: lastCompletedDate) {
            let daysSinceLastCompletion = Calendar.current.dateComponents([.day], from: lastDate, to: today).day ?? 0
            
            if daysSinceLastCompletion == 1 {
                currentStreak += 1
            } else if daysSinceLastCompletion > 1 {
                currentStreak = 1
            }
        } else {
            currentStreak = 1
        }

        if currentStreak > longestStreak {
            longestStreak = currentStreak
        }

        lastCompletedDate = todayString
    }

    func getCurrentStreak() -> Int {
        return currentStreak
    }


    func getLongestStreak() -> Int {
        return longestStreak
    }
}

extension ChallengeStore {
    func getNewChallenge(excluding currentChallenge: Challenge) -> Challenge? {
        return challenges.filter { $0.id != currentChallenge.id }.randomElement()
    }
}


extension UIDevice {
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}



