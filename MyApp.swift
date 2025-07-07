import SwiftUI

@main
struct EmpactApp: App {
    var body: some Scene {
        WindowGroup {
            if !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
                FirstLaunchController()
            } else {
                MainView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
