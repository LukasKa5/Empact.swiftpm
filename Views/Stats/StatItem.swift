import SwiftUI

struct StatItem: View {
    let title: String
    let value: Int
    let icon: String
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text("\(value)")
                .font(.system(size: isIpad ? 30 : 20, weight: .bold))
                .foregroundStyle(Color.blue)
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.black)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: isIpad ? UIScreen.main.bounds.height * 0.1 : UIScreen.main.bounds.height * 0.13)

        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
