//
//  TransactionDetailViewModel.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class TransactionDetailViewModel: ObservableObject {
    @Published private(set) var state: ViewModelingState<TransactionRowItem>?

    private let transactionRowItem: TransactionRowItem
    
    init(transactionRowItem: TransactionRowItem) {
        self.transactionRowItem = transactionRowItem
    }

    func loadData() {
        state = .loading

        self.state = .ready(value: transactionRowItem)
    }
}
