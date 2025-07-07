import SwiftUI

struct LoadingScreenView: View {
    @State private var textOpacity: Double = 1.0
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack {
                Image("BrainWhite")
                    .resizable()
                    .scaledToFit()
    
                
                Text("Loading...")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .opacity(textOpacity)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            textOpacity = 0.3
                        }
                    }
                    .opacity(1)
                    .scaleEffect(1.2)
                    .animation(.easeIn(duration: 0.5), value: 1)
            }
        }
    }
}

#Preview {
    LoadingScreenView()
}
