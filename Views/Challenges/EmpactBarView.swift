import SwiftUI

struct EmpactBarView: View {
    @AppStorage("empactScore") var currentScore = 0
    @AppStorage("empactScoreHistory") private var empactScoreHistoryData: Data = Data()
    private let maxScore: Int = 100
    @State private var lastChallengeDate: Date?

    var body: some View {
        VStack(spacing: 5) {
            Text("Empact Score: \(min(currentScore, maxScore))/\(maxScore)")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.7))
                    .frame(height: UIScreen.main.bounds.height * 0.03)

                RoundedRectangle(cornerRadius: 10)
                    .fill(currentScore >= maxScore ? Color.yellow : Color.green)
                    .overlay(
                        currentScore >= maxScore ?
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange, lineWidth: 2)
                            .shadow(color: Color.yellow.opacity(0.8), radius: 10, x: 0, y: 0)
                        : nil
                    )
                    .frame(
                        width: (CGFloat(min(currentScore, maxScore)) / CGFloat(maxScore)) * UIScreen.main.bounds.width * 0.8,
                        height: UIScreen.main.bounds.height * 0.03
                    )
                    .animation(.easeInOut(duration: 0.5), value: currentScore)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            loadLastChallengeDate()
            decrementScoreIfNeeded()
        }
        .onChange(of: currentScore) { _ in
            decrementScoreIfNeeded()
        }
    }

    private func loadLastChallengeDate() {
        if let storedDate = UserDefaults.standard.object(forKey: "lastChallengeDate") as? Date {
            lastChallengeDate = storedDate
        }
    }
    

    private func decrementScoreIfNeeded() {
        guard let lastChallengeDate = lastChallengeDate else { return }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let daysSinceLastChallenge = calendar.dateComponents([.day], from: lastChallengeDate, to: currentDate).day ?? 0
        
        if daysSinceLastChallenge > 0 {
            var decrement = 0
            for day in 1...daysSinceLastChallenge {
                decrement += min(day, 7)
            }
            
            currentScore = max(currentScore - decrement, 0)
            UserDefaults.standard.set(currentScore, forKey: "empactScore")
        }
    }

    private func setLastChallengeDate(daysAgo: Int) {
        let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date())!
        lastChallengeDate = date
        UserDefaults.standard.set(lastChallengeDate, forKey: "lastChallengeDate")
    }
}







