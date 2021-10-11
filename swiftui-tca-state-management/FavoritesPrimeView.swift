//
//  FavoritesPrimeView.swift
//  swiftui-tca-state-management
//
//  Created by bruno on 11/10/21.
//

import SwiftUI

struct FavoritesPrimeView: View {
    
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            List(state.favoritePrimes, id: \.self) { value in
                Text("\(value)")
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Favorite Primes")
        .preferredColorScheme(.dark)
    }
}

struct FavoritesPrimeView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPrimeView(state: AppState())
    }
}
