//
//  TransactionsService.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation
import Combine
import TrialCore

public protocol TransactionsServicing {
    func transactions() -> Future<[Transaction], APIError>
}

public final class TransactionsService {
    private let transactionsAPI: TransactionsAPI

    public init(transactionsAPI: TransactionsAPI) {
        self.transactionsAPI = transactionsAPI
    }
}

extension TransactionsService: TransactionsServicing {
    public func transactions() -> Future<[Transaction], APIError> {
        transactionsAPI.loadTransactions()
    }
}
