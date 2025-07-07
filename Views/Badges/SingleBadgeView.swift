import SwiftUI

struct SingleBadgeView: View {
    let badge: Badge
    
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        NavigationLink(destination: BadgeDetailView(badge: badge)) {
            VStack {
                Image(badge.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                    .opacity(badge.isUnlocked ? 1.0 : 0.5)

                Text(badge.name)
                    .font(isIpad ? .title2 : .caption)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

