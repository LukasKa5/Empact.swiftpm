import SwiftUI

struct BrainView: View {
    @State private var currentFrame = "Brain"
    @State private var isBlinking = false
    private let imageFrames = ["Brain5", "Brain20", "Brain40", "Brain60", "Brain80", "Brain100", "Brain80", "Brain60", "Brain40", "Brain20", "Brain5"]

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
                startBlinkingLoop()
            }
    }

    private func startBlinkingLoop() {
        blinkAfterDelay()
    }

    private func blinkAfterDelay() {
        let nextBlinkTime = Double.random(in: 5...12)
        DispatchQueue.main.asyncAfter(deadline: .now() + nextBlinkTime) {
            blink()
        }
    }

    private func blink() {
        guard !isBlinking else { return }
        
        isBlinking = true

        Task {
            for (index, frame) in imageFrames.enumerated() {
                await MainActor.run {
                    currentFrame = frame
                }
                let frameDelay = Double.random(in: 0.03...0.07)
                try? await Task.sleep(nanoseconds: UInt64(frameDelay * 1_000_000_000))

                if index == 5 || index == 6 {
                    try? await Task.sleep(nanoseconds: 120_000_000)
                }
            }

         
            await MainActor.run {
                currentFrame = "Brain"
            }

            isBlinking = false
            blinkAfterDelay()
        }
    }
}

#Preview {
    BrainView()
}


