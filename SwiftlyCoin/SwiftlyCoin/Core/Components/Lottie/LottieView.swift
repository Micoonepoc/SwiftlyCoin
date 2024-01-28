import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        
        container.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            animationView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            // Add constraints for width and height to make it smaller
            animationView.widthAnchor.constraint(equalToConstant: 600), // Adjust width as needed
            animationView.heightAnchor.constraint(equalToConstant: 400) // Adjust height as needed
        ])
        
        return container
    }
}

// Preview
struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(animationFileName: "CoinsAnimation", loopMode: .loop)
    }
}
