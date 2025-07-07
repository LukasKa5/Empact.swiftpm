import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    var isActive: Bool
    
    private var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if isActive {
            
            if let emitter = getEmitterLayer(from: uiView) {
                emitter.removeFromSuperlayer()
            }
            
            let emitter = CAEmitterLayer()
            emitter.emitterPosition = CGPoint(x: isIpad ? 400 : 200, y: -50)
            emitter.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
            emitter.emitterShape = .line
            emitter.renderMode = .additive
            emitter.beginTime = CACurrentMediaTime()
            
            var cells: [CAEmitterCell] = []
            let colors: [UIColor] = [.red, .green, .blue, .yellow, .purple, .orange]
            let confettiSize: CGFloat = UIScreen.main.bounds.width > 600 ? 60 : 40
            
            for color in colors {
                let cell = CAEmitterCell()
                cell.birthRate = 25
                cell.lifetime = 5.0
                cell.lifetimeRange = 1.5
                cell.velocity = CGFloat.random(in: 200...300)
                cell.velocityRange = 50
                cell.emissionRange = .pi
                cell.emissionLongitude = .pi / 2
                cell.scale = 0.1
                cell.scaleRange = 0.05
                cell.contents = createConfettiImage(color: color, size: confettiSize)
                cells.append(cell)
            }

            emitter.emitterCells = cells
            uiView.layer.addSublayer(emitter)
        }
    }
    
    private func getEmitterLayer(from view: UIView) -> CAEmitterLayer? {
        
        return view.layer.sublayers?.first(where: { $0 is CAEmitterLayer }) as? CAEmitterLayer
    }

    private func createConfettiImage(color: UIColor, size: CGFloat) -> CGImage? {
        let shape = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size))
        return UIGraphicsImageRenderer(size: CGSize(width: size, height: size)).image { _ in
            color.setFill()
            shape.fill()
        }.cgImage
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView(isActive: true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
    }
}





