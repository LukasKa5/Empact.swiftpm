import SwiftUI

struct TimeframePicker: View {
    @Binding var selectedTimeframe: Timeframe
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(Timeframe.allCases, id: \.self) { timeframe in
                Text(timeframe.rawValue)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(selectedTimeframe == timeframe ? .white : .blue)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(
                        ZStack {
                            if selectedTimeframe == timeframe {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.blue)
                                    .matchedGeometryEffect(id: "pickerSelection", in: animationNamespace)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 4)
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            selectedTimeframe = timeframe
                        }
                    }
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.2))
                .blur(radius: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
    }
}
