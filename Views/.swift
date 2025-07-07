//
//  ConfettiView.swift
//  Empact
//
//  Created by Martin Kaniansky on 06.02.2025.
//


import SwiftUI

struct ConfettiView: View {
    @State private var confettiCount = 0
    @State private var confettiPositions: [CGFloat] = []
    @State private var confettiOffsets: [CGFloat] = []
    @State private var confettiScales: [CGFloat] = []
    @State private var confettiColors: [Color] = []
    @State private var isConfettiVisible = false

    private let colors: [Color] = [.red, .blue, .yellow, .green, .purple, .orange]

    var body: some View {
        ZStack {
            if isConfettiVisible {
                ForEach(0..<confettiCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(confettiColors[index])
                        .frame(width: CGFloat.random(in: 20...40), height: 10)
                        .offset(x: CGFloat.random(in: -UIScreen.main.bounds.width / 2...UIScreen.main.bounds.width / 2),
                                y: confettiOffsets[index])
                        .scaleEffect(confettiScales[index])
                        .animation(
                            Animation
                                .easeInOut(duration: Double.random(in: 1.5...3))
                                .repeatForever(autoreverses: false)
                        )
                        .onAppear {
                            confettiOffsets[index] = -CGFloat.random(in: 100...200)
                            confettiScales[index] = CGFloat.random(in: 0.5...1.0)
                        }
                }
            }
        }
        .onChange(of: confettiCount) { _ in
            isConfettiVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isConfettiVisible = false
            }
        }
        .onAppear {
            startConfettiAnimation()
        }
    }

    private func startConfettiAnimation() {
        // Generate random positions, scales, and colors for confetti
        confettiCount = Int.random(in: 50...100)
        confettiPositions = Array(repeating: 0, count: confettiCount)
        confettiOffsets = Array(repeating: 0, count: confettiCount)
        confettiScales = Array(repeating: 1.0, count: confettiCount)
        confettiColors = (0..<confettiCount).map { _ in colors.randomElement() ?? .red }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                // Trigger confetti animation
            }) {
                Text("Start Confetti")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }

            ConfettiView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
