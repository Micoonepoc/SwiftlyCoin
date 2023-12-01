import SwiftUI

@main
struct SwiftlyCoinApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
