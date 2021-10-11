//
//  IsPrimeModalView.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 11/10/21.
//

import SwiftUI

struct IsPrimeModalView: View {
    
    @Binding var count: Int
    @Binding var favoritePrimes: [Int]
    
    var body: some View {
        VStack {
            if isPrime(count) {
                Text("\(count) is prime 🎉")
                
                if favoritePrimes.contains(count) {
                    Button(action: {}) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {}) {
                        Text("Save to favorite primes")
                    }
                }
            } else {
                Text("\(count) is not prime :(")
            }
        }
    }
    
    private func isPrime (_ p: Int) -> Bool {
      if p <= 1 { return false }
      if p <= 3 { return true }
      for i in 2...Int(sqrtf(Float(p))) {
        if p % i == 0 { return false }
      }
      return true
    }
}

struct IsPrimeModalView_Previews: PreviewProvider {
    static var previews: some View {
        IsPrimeModalView(count: .constant(5), favoritePrimes: .constant([5]))
            .preferredColorScheme(.dark)
    }
}
