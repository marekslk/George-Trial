//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import UIKit
import TrialCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator: InitialSceneCoordinating?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Locator.registerAppServices()

        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = InitialSceneCoordinator(window: window)
        coordinator?.start()
        self.window = window
        
        return true
    }

    // MARK: Keep in mind that app is not supporting multiple windowScenes
}

