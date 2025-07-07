import SwiftUI

struct StartingAnimationView: View {
    private let onAnimationComplete: () -> Void
    @State private var firstLine = Array("Welcome to")
    @State private var secondLine = Array("Empact")
    @State private var firstLinePositions: [CGFloat]
    @State private var secondLinePositions: [CGFloat]
    @State private var imagePosition: CGFloat = -300
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    
    init(onAnimationComplete: @escaping () -> Void) {
        self.onAnimationComplete = onAnimationComplete
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        _firstLinePositions = State(initialValue: Array(repeating: isIpad ? -700 : -330, count: 10))
        _secondLinePositions = State(initialValue: Array(repeating: isIpad ? -700 : -330, count: 6))
    }
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("BrainWhite")
                    .resizable()
                    .scaledToFill()
                    .frame(width: isIpad ? .maximum(800, UIScreen.main.bounds.width) : .maximum(300, UIScreen.main.bounds.width),
                           height: isIpad ? 700 : 300)
                    .offset(y: imagePosition)
                    .onAppear {
                        animateImage()
                    }
                
                textRow(for: firstLine, positions: firstLinePositions)
                textRow(for: secondLine, positions: secondLinePositions)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
        }
        .onAppear {
            animateLetters()
        }
        .portraitOnly()
    }
    
    private func textRow(for text: [Character], positions: [CGFloat]) -> some View {
        HStack(spacing: 4) {
            ForEach(text.indices, id: \.self) { index in
                Text(String(text[index]))
                    .font(.system(size: isIpad ? 80 : 40))
                    .bold()
                    .foregroundColor(.white)
                    .offset(y: positions[index])
            }
        }
    }
    
    private func animateImage() {
        withAnimation(.interpolatingSpring(stiffness: 50, damping: 7)) {
            imagePosition = isIpad ? 100 : 0
        }
    }
    
    private func animateLetters() {
        for letter in firstLine.indices {
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 7).delay(Double(letter) * 0.2 + 1.0)) {
                firstLinePositions[letter] = isIpad ? -150 : -100
            }
        }
        
        for letter in secondLine.indices {
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 7).delay(Double(letter) * 0.2 + 1.5)) {
                secondLinePositions[letter] = isIpad ? -150 : -100
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            withAnimation(.easeIn(duration: 0.2)) {
                onAnimationComplete()
            }
        }
    }
}



