//
//  Amount.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation
import TrialCore

public struct Amount: Decodable {

    public let value: Int
    public let precision: Int
    public let currency: String

}

public extension Amount {

    var decimalValue: NSDecimalNumber {
        get {
            let mantissa =  llabs(Int64(value))
            let exponent = Int16(precision * -1)

            return NSDecimalNumber(
                mantissa: UInt64(mantissa),
                exponent: exponent,
                isNegative: self.value < 0
            )
        }
    }

    init(decimalValue: NSDecimalNumber, currency: String) {
        self.currency = currency
        self.precision = 2

        self.value = decimalValue.integerValueWithPrecision2
    }

}
