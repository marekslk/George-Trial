//
//  TransactionsCoordinator.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import UIKit
import SwiftUI
import Transactions

// MARK: TransactionsCoordinatoring
protocol TransactionsCoordinating: Coordinator {
    func showTransactionDetail(transactionRowItem: TransactionRowItem)
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
                case .detail(let transactionRowItem):
                    self.showTransactionDetail(transactionRowItem: transactionRowItem)
                }
            }
        )
        let viewController = UIHostingController(rootView: transactionsView)
        viewController.navigationItem.largeTitleDisplayMode = .always
        // We need to set title for VC here instead of SwiftUI 
        viewController.title = "transactions.title"//.localized

        navigationController.setViewControllers([viewController], animated: false)
    }

    func showTransactionDetail(transactionRowItem: TransactionRowItem) {
        let transactionDetailView = TransactionDetailView(
            viewModel: TransactionDetailViewModel(transactionRowItem: transactionRowItem),
            onEvent: { event in
                switch event {
                }
            }
        )
        let viewController = UIHostingController(rootView: transactionDetailView)
        // We need to set title for VC here instead of SwiftUI
        viewController.title = "transaction.detail.title"//.localized

        navigationController.pushViewController(viewController, animated: true)
    }
}
