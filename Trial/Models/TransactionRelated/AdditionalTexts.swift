//
//  AdditionalTexts.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public struct AdditionalTexts: Decodable {

    let text1: String
    let text2: String
    let text3: String
    let lineItems: [String]
    let constantSymbol: String?
    let variableSymbol: String?
    let specificSymbol: String?

}
