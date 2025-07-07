import SwiftUI

struct RotatingImageView: View {
    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            Image("BrainWhite")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.6)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    startRotation()
                }
                .animation(
                    Animation.linear(duration: 3).repeatForever(autoreverses: true),
                    value: rotation
                )
        }
        .padding()
    }

    private func startRotation() {
        rotation += 90
    }
}

struct RotatingImageView_Previews: PreviewProvider {
    static var previews: some View {
        RotatingImageView()
    }
}

