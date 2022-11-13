//
//  TransactionItem.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

struct TransactionRowItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String?
    let additionalTexts: [String]
    let amountFormatted: String
}
