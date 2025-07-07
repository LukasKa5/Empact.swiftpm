import SwiftUI

struct PortraitOnlyModifier: ViewModifier {
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            if geometry.size.width < geometry.size.height {
                content
            } else {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            RotatingImageView()
                                
                            Text("Please rotate back to portrait mode")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: isIpad ? -200 : -100)
                        }
                    )
            }
        }
    }
}

extension View {
    func portraitOnly() -> some View {
        self.modifier(PortraitOnlyModifier())
    }
}
