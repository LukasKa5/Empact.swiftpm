import SwiftUI
import Charts

struct StatsChart: View {
    @AppStorage("empactScore") private var empactScore: Int = 0
    
    var timeframeData: [(date: Date, score: Int)]
    var isIpad: Bool

    
    private var cappedData: [(date: Date, score: Int)] {
        timeframeData.map { (date: $0.date, score: min($0.score, 100)) }
    }
    
    var body: some View {
        Chart {
            ForEach(cappedData, id: \.date) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Score", entry.score)
                )
                .interpolationMethod(.catmullRom)
                
                PointMark(
                    x: .value("Date", entry.date),
                    y: .value("Score", entry.score)
                )
                .foregroundStyle(.blue)
            }
        }
        .frame(height: isIpad ? UIScreen.main.bounds.height * 0.45 : UIScreen.main.bounds.height * 0.35)
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom, values: cappedData.map { $0.date }) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel {
                        Text(formatDate(date))
                            .foregroundStyle(.blue)
                    }
                    AxisGridLine()
                        .foregroundStyle(Color.blue.opacity(0.2))
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: .stride(by: 20)) { value in
                if let score = value.as(Int.self) {
                    AxisValueLabel("\(score)")
                        .foregroundStyle(.blue)
                }
                AxisGridLine()
                    .foregroundStyle(Color.white.opacity(0.2))
            }
        }
        .chartYScale(domain: 0...100)
        .padding()
        .id(empactScore)
    }
    
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        
        switch timeframeData.count {
        case 7:
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE"
            return formatter.string(from: date)
            
        case 4:
            if let index = timeframeData.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: date) }) {
                return "W\(index + 1)"
            }
            return "W?"
            
        default:
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            return formatter.string(from: date).prefix(1).uppercased()
        }
    }
}

enum Timeframe: String, CaseIterable {
    case weekly = "Weekly"
    case monthly = "Monthly"
    case yearly = "Yearly"
    

    func getData(from stats: [Date: StatsEntry]) -> [(date: Date, score: Int)] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var filteredStats: [(date: Date, score: Int)] = []

        switch self {
        case .weekly:
            
            var lastKnownScore = 0

            for i in (0..<7).reversed() {
                if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                    let dayStart = calendar.startOfDay(for: date)
                    
                    let score = stats
                        .filter { calendar.isDate($0.key, inSameDayAs: dayStart) }
                        .values
                        .map { $0.empactScore }
                        .max() ?? lastKnownScore
                    
                    filteredStats.append((dayStart, score))
                    lastKnownScore = score
                }
            }

            
        case .monthly:
            
            var lastKnownScore = 0

            for weekIndex in (0..<4).reversed() {
                if let weekStart = calendar.date(byAdding: .weekOfYear, value: -weekIndex, to: today) {
                    let weekStartDate = calendar.startOfDay(for: weekStart)
                    let weekEnd = calendar.date(byAdding: .day, value: 7, to: weekStartDate)!
                    
                    let score = stats
                        .filter { entry in
                            entry.key >= weekStartDate && entry.key < weekEnd
                        }
                        .values
                        .map { $0.empactScore }
                        .max() ?? lastKnownScore
                    
                    filteredStats.append((weekStartDate, score))
                    lastKnownScore = score
                }
            }

        case .yearly:
            var lastKnownScore = 0

            let currentYear = calendar.component(.year, from: today)
            for month in 1...12 {
                if let monthStart = calendar.date(from: DateComponents(year: currentYear, month: month)) {
                    let monthEnd = calendar.date(byAdding: .month, value: 1, to: monthStart)!
                    
                    let score = stats
                        .filter { entry in
                            entry.key >= monthStart && entry.key < monthEnd
                        }
                        .values
                        .map { $0.empactScore }
                        .max() ?? lastKnownScore
                    lastKnownScore = score

                    
                    filteredStats.append((monthStart, score))
                }
            }
        }
        return filteredStats
    }
}




