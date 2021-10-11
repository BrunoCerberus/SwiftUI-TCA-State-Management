//
//  PrimeAlert.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 11/10/21.
//

import SwiftUI

struct PrimeAlert: Identifiable {
    let prime: Int
    var id: Int { self .prime }
}
