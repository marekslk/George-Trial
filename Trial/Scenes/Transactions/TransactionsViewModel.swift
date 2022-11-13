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

// MARK: TransactionsViewModel
final class TransactionsViewModel: ObservableObject {
#warning("TODO")
    private let transactionsApi = TransactionsAPI()

    @Published private(set) var state: ViewModelingState<TransactionsView.Data>?

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

                    let data = self.transactionsViewData(from: transactions)
                    self.state = .ready(value: data)
                }
            )
            .store(in: &cancellables)
    }
}

// MARK: Private
private extension TransactionsViewModel {
    func transactionsViewData(from transactions: [Transaction]) -> TransactionsView.Data {
        let transactionItems = transactionItems(from: transactions)

        let transactionsSum = transactions
            .map { $0.amount.decimalValue.integerValueWithPrecision2 }
            .reduce(0, +)
        let transactionsSumReadable = Double(transactionsSum) / 100
        // It's safe to use EUR as default value
        var balanceFormatted = "\(transactionsSumReadable) \(transactions.first?.amount.currency ?? "EUR")"
        if transactionsSumReadable > 0 {
            balanceFormatted = "+\(balanceFormatted)"
        }

        return TransactionsView.Data(
            transactionsCount: transactions.count,
            balanceFormatted: balanceFormatted,
            items: transactionItems
        )
    }

    func transactionItems(from transactions: [Transaction]) -> [TransactionItem] {
        transactions.map { transaction in
            let amountHumanReadable = Double(transaction.amount.decimalValue.integerValueWithPrecision2) / 100
            let currency = transaction.amount.currency
            var amountFormatted = "\(amountHumanReadable) \(currency)"

            if amountHumanReadable > 0 {
                amountFormatted = "+\(amountFormatted)"
            }

            return TransactionItem(
                id: transaction.id,
                title: transaction.title,
                subtitle: transaction.subtitle,
                additionalTexts: transaction.additionalTexts.lineItems,
                amountFormatted: amountFormatted
            )
        }
    }
}
