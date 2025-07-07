import SwiftUI

struct HappyBrainView: View {
    @State private var currentFrame = "Brain"
    @Binding var isHappy: Bool
    
    private let happyFrames = ["Brainhappy1", "Brainhappy2", "Brainhappy3"]

    private var brainSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return UIDevice.current.userInterfaceIdiom == .pad ? screenWidth * 0.5 : screenWidth * 0.6
    }

    var body: some View {
        Image(currentFrame)
            .resizable()
            .scaledToFit()
            .frame(width: brainSize, height: brainSize)
            .onAppear {
                startFrameLoop()
            }
    }

    private func startFrameLoop() {
        Task {
            for frame in happyFrames {
                await MainActor.run {
                    currentFrame = frame
                }
                try? await Task.sleep(nanoseconds: 150_000_000)
            }
            
            try? await Task.sleep(nanoseconds: 7_000_000_000)

            for frame in happyFrames.reversed() {
                await MainActor.run {
                    currentFrame = frame
                }
                try? await Task.sleep(nanoseconds: 150_000_000)
            }

            await MainActor.run {
                currentFrame = "Brain"
                isHappy = false
            }
        }
    }
}

#Preview {
    HappyBrainView(isHappy: .constant(true))
}





