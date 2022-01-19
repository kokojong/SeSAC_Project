//
//  TVShowViewModel.swift
//  SeSAC_week13_Drama
//
//  Created by kokojong on 2021/12/29.
//

import Foundation

class TVShowViewModel {
    
//    var
    
    var searchedTVShow: Observable<TVShow> = Observable(TVShow(page: 1, results: [], totalPages: 1, totalResults: 1))
    
    func searchTVShow(searhText: String) {
        APIService.searchTVShow(searchText: searhText) { tvshow, error in
            
            print("tvshow : ",tvshow)
//            print("error : ",error)
            
//            guard let tvshow = tvshow else {
//                return
//            }
            let tvshow = tvshow ?? TVShow(page: 0, results: [], totalPages: 0, totalResults: 0) // nil 처리
            self.searchedTVShow.value = tvshow
            
        }
    }
    
    
}

extension TVShowViewModel {
    var numberOfItemsInSection: Int {
        return searchedTVShow.value.results.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> Result {
        return searchedTVShow.value.results[indexPath.item]
    }
}
