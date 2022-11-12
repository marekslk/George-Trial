//
//  InitialSceneCoordinator.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import UIKit

// MARK: InitialSceneCoordinating
protocol InitialSceneCoordinating: Coordinator {
    init(window: UIWindow)
}

// MARK: InitialSceneCoordinator
final class InitialSceneCoordinator: InitialSceneCoordinating {
    private let window: UIWindow

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        setupNavigationController()
        setupInitialScene()
    }
}

private extension InitialSceneCoordinator {
    func setupNavigationController() {
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func setupInitialScene() {
        let transactionsCoordinator = TransactionsCoordinator(parent: self, navigationController: navigationController)
        transactionsCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // Check if user was onboarded already. If not, show onboarding.
        if UserDefaultsProvider.userWasOnboarded == false {
            let onboardingCoordinator = OnboardingCoordinator(parent: self)
            onboardingCoordinator.start()

            childCoordinators.append(onboardingCoordinator)
            navigationController.present(onboardingCoordinator.navigationController, animated: false)
        }
    }
}
