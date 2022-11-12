//
//  OnboardingCoordinator.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: InitialSceneCoordinating
protocol OnboardingCoordinating: Coordinator {
}

// MARK: InitialSceneCoordinator
final class OnboardingCoordinator: OnboardingCoordinating {

    weak var parent: Coordinator?

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()

    init(parent: Coordinator) {
        self.parent = parent
    }

    func start() {
        navigationController.modalPresentationStyle = .fullScreen
        
        let onboardingView = OnboardingView(onEvent: { [weak self] event in
            guard let self else { return }

            switch event {
            case .dismiss:
                UserDefaultsProvider.userWasOnboarded = true
                self.dismiss()
                self.parent?.childDidFinish(self)
            }
        })
        let viewController = UIHostingController(rootView: onboardingView)
        navigationController.setViewControllers([viewController], animated: false)
    }

    private func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
