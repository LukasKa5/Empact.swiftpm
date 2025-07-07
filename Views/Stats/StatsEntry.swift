import Foundation

struct StatsEntry: Codable {
    var empactScore: Int
    var date: Date
    
    init(empactScore: Int, date: Date = Date()) {
        self.empactScore = empactScore
        self.date = date
    }
}
