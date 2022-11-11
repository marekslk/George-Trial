//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import XCTest
import Combine
@testable import Trial

class TrialTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func testTransactionParsing() {
        let api = TransactionsAPI()

        let expectation = XCTestExpectation(description: "Load transactions")
        
        api.loadTransactions()
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
