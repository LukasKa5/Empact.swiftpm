import SwiftUI
import Charts

struct StatsView: View {
    @AppStorage("peopleHelped") private var totalPeopleHelped: Int = 0
    @AppStorage("goodDeedsCompleted") private var totalGoodDeeds: Int = 0
    @AppStorage("empactScore") private var empactScore: Int = 0
    @AppStorage("longestStreak") private var longestStreak: Int = 0
    @AppStorage("statsHistory") private var statsHistory: Data = Data()
    
    @State private var selectedTimeframe: Timeframe = .weekly
    @State private var selectedStat = 0
    @State private var forceUpdate: Bool = false
    
    private var userStats: [Date: StatsEntry] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let decodedStats = try? JSONDecoder().decode([String: StatsEntry].self, from: statsHistory) {
            return decodedStats.compactMapKeys { formatter.date(from: $0) }
        }
        return [:]
    }
    
    var timeframeData: [(date: Date, score: Int)] {
        _ = forceUpdate
        return selectedTimeframe.getData(from: userStats)
    }
    
    var body: some View {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        
        VStack(spacing: 30) {
            CardView {
                VStack {
                    TimeframePicker(selectedTimeframe: $selectedTimeframe)
                    
                    Text("📊 \(selectedTimeframe.rawValue) Progress")
                        .foregroundStyle(.blue)
                        .font(.title2)
                        .bold()
                    
                    Divider()
                    
                    StatsChart(timeframeData: timeframeData, isIpad: isIpad)
                        .id(empactScore)
                }
            }
            
            if isIpad {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                    StatItem(title: "Estimated People Helped", value: totalPeopleHelped, icon: "person.3.fill")
                    StatItem(title: "Total Tasks Completed", value: totalGoodDeeds, icon: "checkmark.circle.fill")
                    StatItem(title: "Total Empact Score", value: empactScore, icon: "flame.fill")
                    StatItem(title: "Longest Daily Streak", value: longestStreak, icon: "bolt.fill")
                }
            } else {
                VStack {
                    TabView(selection: $selectedStat) {
                        StatItem(title: "Estimated People Helped", value: totalPeopleHelped, icon: "person.3.fill").tag(0)
                        StatItem(title: "Total Tasks Completed", value: totalGoodDeeds, icon: "checkmark.circle.fill").tag(1)
                        StatItem(title: "Total Empact Score", value: empactScore, icon: "flame.fill").tag(2)
                        StatItem(title: "Longest Daily Streak", value: longestStreak, icon: "bolt.fill").tag(3)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack(spacing: 10) {
                        ForEach(0..<4, id: \.self) { dotIndex in
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 2)
                                .frame(width: 12, height: 12)
                                .background(Circle().fill(selectedStat == dotIndex ? Color.white : Color.clear))
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        selectedStat = dotIndex
                                    }
                                }
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.85)
        .padding()
        .navigationTitle("Statistics")
        .onChange(of: empactScore) { _ in
            forceUpdate.toggle()
        }
    }
}

extension Dictionary {
    func compactMapKeys<T: Hashable>(_ transform: (Key) -> T?) -> [T: Value] {
        var result: [T: Value] = [:]
        for (key, value) in self {
            if let newKey = transform(key) {
                result[newKey] = value
            }
        }
        return result
    }
}











