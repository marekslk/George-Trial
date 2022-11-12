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
    func showTransactionDetail(transactionItem: TransactionItem)
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
                case .detail(let transactionItem):
                    self.showTransactionDetail(transactionItem: transactionItem)
                }
            }
        )
        let viewController = UIHostingController(rootView: transactionsView)
        viewController.navigationItem.largeTitleDisplayMode = .always
        // We need to set title for VC here instead of SwiftUI 
        viewController.title = "transactions.title".localized

        navigationController.setViewControllers([viewController], animated: false)
    }

    func showTransactionDetail(transactionItem: TransactionItem) {
        let transactionDetailView = TransactionDetailView(
            viewModel: TransactionDetailViewModel(transactionItem: transactionItem),
            onEvent: { event in
                switch event {
                }
            }
        )
        let viewController = UIHostingController(rootView: transactionDetailView)
        // We need to set title for VC here instead of SwiftUI
        viewController.title = "transaction.detail.title".localized

        navigationController.pushViewController(viewController, animated: true)
    }
}
