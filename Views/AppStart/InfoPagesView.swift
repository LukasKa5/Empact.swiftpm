import SwiftUI

struct InfoPage {
    let image: String
    let title: String
    let description: String
}

struct InfoPagesView: View {
    @State private var currentPage = 0
    @State private var shouldShowMainApp = false
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    let pages: [InfoPage] = [
        InfoPage(
            image: "BrainImage",
            title: "What is Empact?",
            description: "Empact is an app for everyone who wants to make a real difference. Track your good deeds, see your impact grow, and turn small actions into meaningful change."
        ),
        InfoPage(
            image: "HomeImage",
            title: "How does it work?",
            description:  "Collect Empact score by completing good deeds (challenges) and try to reach 100 to become an Empact Champion! But be aware that your score will decrease each day you don’t complete a challenge."
        ),
        InfoPage(
            image: "StatsImage",
            title: "Track your impact",
            description: "Want to see how you're improving over time? Track your progress and watch your impact grow daily!"
        ),
        InfoPage(
            image: "BadgeImage",
            title: "Get your rewards",
            description: "No one leaves Empact without a reward! Everyone striving to make the world a better place deserves recognition."
        )
    ]
    
    var body: some View {
        if shouldShowMainApp {
           MainView()
                .transition(.opacity)
        } else {
            ZStack {
                Color.blue.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    TabView(selection: $currentPage) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            VStack(spacing: 20) {
                                Image(pages[index].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 1.2)
                                
                                Text(pages[index].title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text(pages[index].description)
                                    .font(isIpad ? .title3 : .callout)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
                    
                    Button(action: {
                        if currentPage == pages.count - 1 {
                            withAnimation {
                                shouldShowMainApp = true
                                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                            }
                        } else {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                    }) {
                        Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.blue)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 50)
                }
            }
            .portraitOnly()
        }
    }
}




#Preview {
    InfoPagesView()
        .preferredColorScheme(.dark)

}
