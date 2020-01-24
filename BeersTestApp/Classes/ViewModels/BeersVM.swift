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
    
    private var page = 1
    let countPerPage = 10
    
    let title = "Beers" 
    
    
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
    
}
