//
//  Stock.swift
//  portofliosort
//
//  Created by Asmit Datta on 11/5/26.
//

import Foundation

struct Stock {
    let symbol: String
    let price: Decimal
    var shares: Int

    var holdingValue: Decimal {
        price * Decimal(shares)
    }
}
