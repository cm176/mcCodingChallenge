//
//  NumberFormatterExtension.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import Foundation

extension NumberFormatter {
    func formatMoney(amount: Decimal) -> String {
        self.numberStyle = .currency
        self.locale = Locale(identifier: "en_US")
        
        if let formattedAmount = self.string(from: amount as NSNumber) {
            return formattedAmount
        } else {
            // Formatting failed
            return "$0.00"
        }
    }
}
