import SwiftUI

struct BadgeDetailView: View {
    let badge: Badge
    @State private var rotationAngle: Double = 0
    @Environment(\.dismiss) var dismiss

    var completedChallenges: Int {
        let categoryCompletionCounts = UserDefaults.standard.dictionary(forKey: "categoryCompletionCounts") as? [String: Int] ?? [:]
        return categoryCompletionCounts[badge.category] ?? 0
    }

    let badgeThresholds: [String: [(count: Int, badgeName: String)]] = [
        "Self-Care": [(1, "Self-Care Guru"), (10, "Empact Fanatic"), (100, "Self-Improver")],
        "Environment": [(1, "Green Guardian"), (10, "Earth Defender"), (100, "Captain Planet 2.0")],
        "Community": [(1, "High-Five Hero"), (10, "Happiness Distributor"), (100, "The People's Champion")]
    ]

    var requiredChallenges: Int {
        return badgeThresholds[badge.category]?.first(where: { $0.badgeName == badge.name })?.count ?? 0
    }

    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.top, 30)
                }
                .padding(.trailing, 20)
            }

            Text(badge.name)
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .padding(.top, isIpad ? UIScreen.main.bounds.width * 0.05 : UIScreen.main.bounds.width * 0.05)
                .padding(.bottom, UIScreen.main.bounds.width * 0.05)
            
            Divider()
            
            VStack {

                Image(badge.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: isIpad ? UIScreen.main.bounds.width * 0.4 : UIScreen.main.bounds.width * 0.7,
                        height: isIpad ? UIScreen.main.bounds.height * 0.4 : UIScreen.main.bounds.height * 0.6
                    )
                    .padding()
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.easeInOut(duration: 1), value: rotationAngle)
                    .onTapGesture { rotationAngle += 360 }
                    .onAppear {
                        rotationAngle = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            rotationAngle = 360
                        }
                    }

                
                VStack {
                    if badge.isUnlocked {
                        Text("✅ Badge Unlocked!")
                            .foregroundColor(.green)
                            .bold()
                    } else {
                        Text("🔒 Not Unlocked Yet")
                            .foregroundColor(.red)
                            .bold()
                    }

                    if requiredChallenges > 0 {
                        Text("Progress: \(completedChallenges) / \(requiredChallenges) challenges")
                            .foregroundColor(.black)
                            .padding(.top, 5)

                        ProgressView(value: Double(completedChallenges), total: Double(requiredChallenges))
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .frame(
                                width: isIpad ? UIScreen.main.bounds.width * 0.3 : UIScreen.main.bounds.width * 0.6
                            )
                    }
                    
                    Text("How to unlock: \(badge.description)")
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .foregroundColor(.black)
                        .font(.body)
                        .padding(.top, 20)
                        .padding(.bottom, isIpad ? 50 : 0)
                }
                .padding(.top, UIScreen.main.bounds.height * -0.05)
            }
            .padding(.top, -80)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}





