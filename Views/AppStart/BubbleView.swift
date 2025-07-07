import SwiftUI

struct BubbleView: View {
    let text: String
    let onContinue: () -> Void
    @State private var isAnimating = false
    @State private var showText = false
    @State private var showButton = false
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    private var bubbleWidth: CGFloat {
        if isIpad {
            return min(screenWidth * 0.8, 800)
        } else {
            return min(screenWidth * 0.85, 500)
        }
    }
    
    private var fontSize: CGFloat {
        if isIpad {
            return 28
        } else {
            return screenWidth < 380 ? 18 : 20
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: screenHeight * 0.02) {
                ZStack(alignment: .bottom) {
                
                    VStack(spacing: isIpad ? 30 : 20) {
                        if showText {
                            Text(text)
                                .font(.system(size: fontSize, weight: .medium))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.top, isIpad ? 40 : 25)
                                .padding(.horizontal, isIpad ? 50 : 30)
                                .transition(.opacity.combined(with: .scale))
                        }
                        
                        if showButton {
                            Button(action: onContinue) {
                                Text("Continue")
                                    .font(.system(size: fontSize * 0.9, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, isIpad ? 60 : 40)
                                    .padding(.vertical, isIpad ? 15 : 12)
                                    .background(
                                        Capsule()
                                            .fill(Color.green)
                                    )
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, isIpad ? 40 : 25)
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: isIpad ? 40 : 30)
                            .fill(Color.white)
                            .shadow(radius: 12)
                    )
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: isIpad ? 40 : 20,
                               height: isIpad ? 40 : 20)
                        .foregroundColor(.white)
                        .offset(y: isIpad ? 50 : 25)
                        .shadow(radius: 12)
                }
                .frame(width: bubbleWidth)
                .frame(minHeight: isIpad ? 200 : 150)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .opacity(isAnimating ? 1 : 0)
            }
            .padding(isIpad ? 50 : 30)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isAnimating = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeIn(duration: 0.3)) {
                    showText = true
                }
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        showButton = true
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        BubbleView(text: "Hello!") {
        }
    }
}
