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
    
    let title = "Beers"
    
    var isFirstPage: Bool {
        return currentPage == 1
    }
    
    
    // MARK: Public funcs
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return beers.count
    }
    
    func item(at index: Int) -> Beer? {
        return beers[safe: index]
    }
    
    
    func getBeers(completion: @escaping Completion, failure: @escaping FailureHandler) {
        let params = GetBeersParameters(page: currentPage, countPerPage: BeersVM.countPerPage)
        WebService.shared.getBeers(with: params, completion: { [weak self] beersArray in
            self?.beers.append(contentsOf: beersArray)
            if beersArray.count == BeersVM.countPerPage {
                self?.currentPage += 1
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
            }, failure: { error in
                DispatchQueue.main.async {
                    failure(error)
                }
        })
    }
    
}
