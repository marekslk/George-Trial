//
//  Transaction.swift
//  Trial
//
//  Created by Marek Slávik on 13.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public struct Transaction: Decodable {

    let id: String
    let title: String
    let subtitle: String?
    let sender: AccountNumber
    let senderName: String?
    let senderOriginator: String?
    let senderReference: String
    let senderBankReference: String?
    let receiver: AccountNumber
    let receiverName: String?
    let receiverReference: String
    let creditorId: String
    let amount: Amount
    let amountSender: Amount
    let bookingDate: Date
    let valuationDate: Date
    let importDate: Date
    let dueDate: Date?
    let exchangeDate: Date?
    let insertTimestamp: Date
    let reference: String
    let originatorSystem: String
    let additionalTexts: AdditionalTexts
    let note: String?
    let bookingType: String
    let bookingTypeTranslation: String?
    let orderRole: String
    let orderCategory: String?
    let cardId: String
    let maskedCardNumber: String
    let invoiceId: String?
    let location: String
    let partnerName: String?
    let partnerOriginator: String?
    let partnerAddress: [String]

}
