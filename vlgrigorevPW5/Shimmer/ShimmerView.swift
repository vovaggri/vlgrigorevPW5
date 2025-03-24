import UIKit

final class ShimmerView: UIView {
    enum Constants {
        static let firstGradientColor: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        static let secondGradientColor: CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        
        static let startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)
        static let endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)
        
        static let gradientLayerLocations: [NSNumber] = [0.0, 0.5, 1.0]
        
        static let keyPath: String = "locations"
        
        static let fromValue: [NSNumber] = [-1.0, -0.5, 0.0]
        static let toValue: [NSNumber] = [1.0, 1.5, 2.0]
        
        static let animationDuration = 0.9
    }
    
    var gradientColorOne : CGColor = Constants.firstGradientColor
    var gradientColorTwo : CGColor = Constants.secondGradientColor
    
    func addGradientLayer() -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        print(gradientLayer.frame)
        gradientLayer.startPoint = Constants.startPoint
        gradientLayer.endPoint = Constants.endPoint
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = Constants.gradientLayerLocations
        self.layer.addSublayer(gradientLayer)
        
        return gradientLayer
    }
    
    func addAnimation() -> CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = Constants.fromValue
        animation.toValue = Constants.toValue
        animation.repeatCount = .infinity
        animation.duration = Constants.animationDuration
        return animation
    }
    
    func startAnimating() {
        
        let gradientLayer = addGradientLayer()
        let animation = addAnimation()
        
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}
