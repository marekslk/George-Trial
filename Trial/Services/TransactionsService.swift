//
//  TransactionsService.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation
import Combine

protocol TransactionsServicing {
    func transactions() -> Future<[Transaction], APIError>
}

final class TransactionsService {
    private let transactionsAPI: TransactionsAPI

    init(transactionsAPI: TransactionsAPI) {
        self.transactionsAPI = transactionsAPI
    }
}

extension TransactionsService: TransactionsServicing {
    func transactions() -> Future<[Transaction], APIError> {
        transactionsAPI.loadTransactions()
    }
}
