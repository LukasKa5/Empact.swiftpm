import SwiftUI

@MainActor
class WakeUpAnimationManager: ObservableObject {
    @Published var frameIndex = 1
    @Published var shouldKeepLastFrame = false
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.frameIndex = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.frameIndex = 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.frameIndex = 3
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.frameIndex = 4
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.frameIndex = 5
                            self.shouldKeepLastFrame = true
                        }
                    }
                }
            }
        }
    }
}

struct WakeUpView: View {
    let onContinueTapped: () -> Void
    
    @StateObject private var wakeUpAnimationManager = WakeUpAnimationManager()
    @State private var showBubble = false
    
    var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            if wakeUpAnimationManager.shouldKeepLastFrame {
                Image("WakeUp5")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.7)
            } else {
                Image("WakeUp\(wakeUpAnimationManager.frameIndex)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.7)
            }
            
            if showBubble {
                VStack {
                    BubbleView(text: "Hey there, you just woke me up! How many good deeds did you make last week? No worries, I don't know either! Let me show you around Empact!") {
                        onContinueTapped()
                    }
                    Spacer()
                }
                .padding(.top, isIpad ? UIScreen.main.bounds.height * 0.02 + 100 : UIScreen.main.bounds.height * 0.03)
                .transition(.opacity)
            }
        }
        .onAppear {
            wakeUpAnimationManager.startAnimation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeIn(duration: 0.3)) {
                    showBubble = true
                }
            }
        }
        .portraitOnly()
    }
}



