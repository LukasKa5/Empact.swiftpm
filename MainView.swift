import SwiftUI

struct MainView: View {
    @AppStorage("empactScore") private var empactScore = 0
    @State private var selectedTab = 0
    @State private var isHappy = false
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    if selectedTab == 0 {
                        HomeView(currentScore: empactScore, isHappy: $isHappy)
                            .ignoresSafeArea(.all, edges: .bottom)
                    } else if selectedTab == 1 {
                        StatsView()
                    } else if selectedTab == 2 {
                        BadgesView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: UIScreen.main.bounds.width * 0.85,
                               height: isIpad ? UIScreen.main.bounds.height * 0.06 : UIScreen.main.bounds.height * 0.09)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Spacer()
                        NavButton(icon: "house.fill", label: "Home", isSelected: selectedTab == 0) {
                            withAnimation { selectedTab = 0 }
                        }
                        
                        Spacer()
                        NavButton(icon: "chart.bar.fill", label: "Stats", isSelected: selectedTab == 1) {
                            withAnimation { selectedTab = 1 }
                        }
                        
                        Spacer()
                        NavButton(icon: "rosette", label: "Badges", isSelected: selectedTab == 2) {
                            withAnimation { selectedTab = 2 }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 10)
                }
                .padding(.bottom, isIpad ? 0 : -5)
            }
            .background(Color.blue.edgesIgnoringSafeArea(.all))
            
            if isHappy {
                ConfettiView(isActive: true)
                    .allowsHitTesting(false)
            }
        }
        .preferredColorScheme(.dark)
        .portraitOnly()
    }
}

struct NavButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            if isSelected {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
            } else {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(.blue).opacity(0.3)
            }
        
            Text(label)
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding(.top, 5)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)

}






