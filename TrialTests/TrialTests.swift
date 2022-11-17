//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import XCTest
import Combine
import TrialCore
import Transactions
@testable import Trial

class TrialTests: XCTestCase {
    @Locatable private var transactionsService: TransactionsServicing

    private var cancellables = Set<AnyCancellable>()
    
    func testTransactionParsing() {
        let expectation = XCTestExpectation(description: "Load transactions")
        
        transactionsService.transactions()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        XCTFail("Received error: \(error)")
                    case .finished:
                        break
                    }
                    expectation.fulfill()
                },
                receiveValue: { transactions in
                    XCTAssertEqual(45, transactions.count)
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }
    
}
