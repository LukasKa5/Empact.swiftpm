import SwiftUI

class SleepingAnimationManager: ObservableObject {
    @Published var frameIndex = 1
    private let totalFrames = 29
    private let animationSpeed = 0.1
    private var timer: Timer?
    
    func startAnimation() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: animationSpeed, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.frameIndex < self.totalFrames {
                    self.frameIndex += 1
                } else {
                    self.frameIndex = 1
                }
            }
        }
    }
    
    func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

struct SleepingView: View {
    let onWakeUpTapped: () -> Void
    @StateObject private var animationManager = SleepingAnimationManager()
    @State private var textOpacity: Double = 1.0
    
    var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            Image("Sleeping\(animationManager.frameIndex)")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .onAppear {
                    animationManager.startAnimation()
                }
            
            Spacer()
            
            Text("Click here to wake up the brain")
                .font(isIpad ? .title : .title3)
                .foregroundColor(.white)
                .bold()
                .opacity(textOpacity)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        textOpacity = 0.3
                    }
                }
                .onTapGesture {
                    animationManager.stopAnimation()
                    onWakeUpTapped()
                }
                .padding(.top, UIScreen.main.bounds.height * 0.7)
        }
        .portraitOnly()
    }
}






