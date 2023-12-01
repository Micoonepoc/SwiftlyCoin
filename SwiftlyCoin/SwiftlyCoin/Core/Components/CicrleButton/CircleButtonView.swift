import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(Color.colorTheme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.colorTheme.background)
            )
            .shadow(color: Color.colorTheme.accent.opacity(0.3),
                    radius: 10,
                    x: 0,
                    y: 0)
            .padding()
    }
}

#Preview {
    CircleButtonView(imageName: "info")
}
