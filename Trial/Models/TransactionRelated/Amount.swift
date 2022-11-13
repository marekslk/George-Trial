//
//  Amount.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public struct Amount: Decodable {

    let value: Int
    let precision: Int
    let currency: String

}

extension Amount {

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

    public init(decimalValue: NSDecimalNumber, currency: String) {
        self.currency = currency
        self.precision = 2

        self.value = decimalValue.integerValueWithPrecision2
    }

}
