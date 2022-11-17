//
//  NSDecimalNumberExtensions.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public extension NSDecimalNumber {

    var integerValueWithPrecision2: Int {
        let decimalNumberBehavior = NSDecimalNumberHandler(
            roundingMode: NSDecimalNumber.RoundingMode.plain,
            scale: 0,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )

        let beforeComma = self.rounding(accordingToBehavior: decimalNumberBehavior)
        let afterComma = self.subtracting(beforeComma)

        let beforeCommaMultipliedBy100 = beforeComma.multiplying(
            byPowerOf10: 2,
            withBehavior: decimalNumberBehavior
        )

        if afterComma != NSDecimalNumber.zero {
            let afterCommaCommaMultipliedBy100 = afterComma.multiplying(
                byPowerOf10: 2,
                withBehavior: decimalNumberBehavior
            )
            return beforeCommaMultipliedBy100.adding(afterCommaCommaMultipliedBy100).intValue
        } else {
            return beforeCommaMultipliedBy100.intValue
        }
    }

}
