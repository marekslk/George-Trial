//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import Foundation
import Combine
import TrialCore

public final class TransactionsAPI {

    /// Loads a list of transaction - you can assume that all transactions have the same currency
    public func loadTransactions() -> Future<[Transaction], APIError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(arc4random_uniform(5000)) / 1000.0)) { [weak self] in
                guard let self else {
                    return
                }

                switch arc4random_uniform(100) {
                case 0..<25:
                    promise(.failure(.randomError))
                default:
                    promise(.success(self.readTransactions()))
                }
            }
        }
    }
    
    private func readTransactions() -> [Transaction] {
        let file = Bundle(for: TransactionsAPI.self).path(forResource: "transactions", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file), options: [])
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970
            let transactionResponse = try decoder.decode(TransactionResponse.self, from: data)
            return transactionResponse.collection
        } catch let error {
            assertionFailure("Got error \(error) while parsing transactions.")
            return [Transaction]()
        }
    }

}
