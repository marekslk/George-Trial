//
//  TransactionItem.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public struct TransactionRowItem: Identifiable {
    public let id: String
    public let title: String
    public let subtitle: String?
    public let additionalTexts: [String]
    public let amountFormatted: String
}
