//
//  TransactionsCoordinator.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: TransactionsCoordinatoring
protocol TransactionsCoordinating: Coordinator {
}

// MARK: TransactionsCoordinator
final class TransactionsCoordinator: TransactionsCoordinating {

    weak var parent: Coordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(parent: Coordinator, navigationController: UINavigationController) {
        self.parent = parent
        self.navigationController = navigationController
    }

    func start() {
        let transactionsView = TransactionsView(
            viewModel: TransactionsViewModel(),
            onEvent: { event in
                switch event {
                }
            }
        )
        let viewController = UIHostingController(rootView: transactionsView)
        viewController.navigationItem.largeTitleDisplayMode = .always
        // We need to set title for VC here instead of SwiftUI 
        viewController.title = "transactions.title".localized
        navigationController.setViewControllers([viewController], animated: false)
    }
}
