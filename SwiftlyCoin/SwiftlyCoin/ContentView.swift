import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Accent Color")
                .foregroundStyle(Color.colorTheme.accent)
            Text("Background Color")
                .foregroundStyle(Color.colorTheme.background)
            Text("Green Color")
                .foregroundStyle(Color.colorTheme.green)
            Text("Red Color")
                .foregroundStyle(Color.colorTheme.red)
            Text("Secundary Text Color")
                .foregroundStyle(Color.colorTheme.secondaryText)
        }
    }
    
}

#Preview {
    ContentView()
}

