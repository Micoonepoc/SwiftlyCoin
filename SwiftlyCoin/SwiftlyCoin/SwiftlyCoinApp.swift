import SwiftUI

@main
struct SwiftlyCoinApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.colorTheme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.colorTheme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
