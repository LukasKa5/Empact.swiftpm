import SwiftUI

enum FirstLaunchState {
    case loading
    case sleeping
    case waking
    case info
}

struct FirstLaunchController: View {
    @State private var currentState: FirstLaunchState = .loading
    @State private var showLoading = true
    
    var body: some View {
        ZStack {
            if showLoading {
                LoadingScreenView()
            } else {
                Color.blue.ignoresSafeArea()
                
                switch currentState {
                case .loading:
                    StartingAnimationView(onAnimationComplete: {
                        withAnimation {
                            currentState = .sleeping
                        }
                    })
                    
                case .sleeping:
                    SleepingView(onWakeUpTapped: {
                        currentState = .waking
                    })
                    
                case .waking:
                    WakeUpView(onContinueTapped: {
                        withAnimation {
                            currentState = .info
                        }
                    })
                    
                case .info:
                    InfoPagesView()
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showLoading = false
                }
            }
        }
    }
}

#Preview {
    FirstLaunchController()
}
