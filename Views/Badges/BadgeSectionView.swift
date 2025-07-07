import SwiftUI

struct BadgeSectionView: View {
    let title: String
    let badges: [Badge]
    @Binding var selectedBadge: Badge?
    
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
                .underline()

            GeometryReader { geometry in
                let columns = [
                    GridItem(.adaptive(minimum: geometry.size.width / 4))
                ]
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(badges) { badge in
                        SingleBadgeView(badge: badge)
                            .onTapGesture {
                                selectedBadge = badge
                            }
                    }
                }
            }
            .frame(height: isIpad ? UIScreen.main.bounds.height * 0.23 : UIScreen.main.bounds.height * 0.17)
        }
    }
}
