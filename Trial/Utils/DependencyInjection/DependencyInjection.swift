//
//  DependencyInjection.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation
import TrialCore
import Transactions

public extension Locator {
    /// Used to setup all app related services
    static func registerAppServices() {
        let transactionsAPI = TransactionsAPI()

        Locator.register(
            TransactionsServicing.self,
            TransactionsService(transactionsAPI: transactionsAPI)
        )
    }
}
