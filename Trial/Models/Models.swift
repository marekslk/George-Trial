//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import Foundation

// MARK: APIError
public enum APIError: Error {
    
    case randomError
    
}

// MARK: Transaction
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

// MARK: AccountNumber
public struct AccountNumber: Decodable {
    
    let iban: String?
    let bic: String?
    let number: String?
    let bankCode: String?
    let prefix: String?
    let countryCode: String?
    
}

// MARK: AdditionalTexts
public struct AdditionalTexts: Decodable {
    
    let text1: String
    let text2: String
    let text3: String
    let lineItems: [String]
    let constantSymbol: String?
    let variableSymbol: String?
    let specificSymbol: String?
    
}

// MARK: Amount
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

// MARK: TransactionResponse
public struct TransactionResponse: Decodable {
    
    let collection: [Transaction]
    
}
