//
//  AccountNumber.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public struct AccountNumber: Decodable {

    let iban: String?
    let bic: String?
    let number: String?
    let bankCode: String?
    let prefix: String?
    let countryCode: String?

}
