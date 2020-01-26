//
//  BeersVM.swift
//  BeersTestApp
//
//  Created by Roman Rybachenko on 24.01.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation


class BeersVM {
    
    // MARK: - Properties
    private var beers: [Beer] = []
    
    private var currentPage = 1
    private static let countPerPage = 10
    
    var beerItemsCount: Int {  return beers.count }
    
    let title = "Beers"
    
    private (set) var isLoading = false
    private (set) var allPagesLoaded = false
    
    
    // MARK: Public funcs
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return beers.count
    }
    
    func beerItem(at index: Int) -> Beer? {
        return beers[safe: index]
    }
    
    
    func getBeers(completion: @escaping Completion, failure: @escaping FailureHandler) {
        let params = GetBeersParameters(page: currentPage, countPerPage: BeersVM.countPerPage)
        isLoading = true
        WebService.shared.getBeers(with: params, completion: { [weak self] beersArray in
            self?.beers.append(contentsOf: beersArray)
            if beersArray.count == BeersVM.countPerPage {
                self?.currentPage += 1
            } else {
                self?.allPagesLoaded = true
            }
            self?.isLoading = false
            DispatchQueue.main.async {
                completion()
            }
            
            }, failure: { [weak self] error in
                self?.isLoading = false
                DispatchQueue.main.async {
                    failure(error)
                }
        })
    }
    
}
