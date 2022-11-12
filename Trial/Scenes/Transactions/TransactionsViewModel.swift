//
//  TransactionsViewModel.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

//- title, subtitle, additionalTexts.lineItems and amount of the transaction in the list of transactions.

struct TransactionItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String?
    let additionalTexts: [String]
}

final class TransactionsViewModel: ObservableObject {
    private let transactionsApi = TransactionsAPI()

    @Published private(set) var state: ViewModelingState<[TransactionItem]>?

    private var latestTransactions = [Transaction]()
    private var cancellables = Set<AnyCancellable>()

    func loadData() {
        state = .loading
        
        transactionsApi.loadTransactions()
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.state = .failed(error: error)
                    }
                },
                receiveValue: { [weak self] transactions in
                    guard let self else { return }

                    self.latestTransactions = transactions
                    let transactionItems = self.transactionItems(from: transactions)
                    self.state = .ready(value: transactionItems)
                }
            )
            .store(in: &cancellables)
    }

    private func transactionItems(from transactions: [Transaction]) -> [TransactionItem] {
        transactions.map { transaction in
            TransactionItem(
                id: transaction.id,
                title: transaction.title,
                subtitle: transaction.subtitle,
                additionalTexts: transaction.additionalTexts.lineItems
            )
        }
    }
}
