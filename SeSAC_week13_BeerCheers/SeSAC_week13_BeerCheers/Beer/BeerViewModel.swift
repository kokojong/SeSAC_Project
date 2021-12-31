//
//  BeerViewModel.swift
//  SeSAC_week13_BeerCheers
//
//  Created by kokojong on 2021/12/30.
//

import Foundation

class BeerViewModel {
    
    var beer: Observable<Beer> = Observable(Beer())

    func fetchRandomBeer() {
        APIService.fetchRandomBeer { beer, error in
            
            guard let beer = beer else {
                return
            }
            self.beer.value = beer
        }
    }


    
}
