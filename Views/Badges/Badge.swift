import SwiftUI

struct Badge: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String
    var isUnlocked: Bool
    let description: String
}



