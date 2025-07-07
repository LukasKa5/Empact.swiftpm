import SwiftUI

struct Challenge: Identifiable, Encodable, Decodable {
    var id = UUID()
    let name: String
    let time: String
    let empactScore: Int
    let category: String
    let funFact: String
    let estPeopleHelped: Int
}
