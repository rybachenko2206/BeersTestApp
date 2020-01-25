//
//  WebService.swift
//  BeersTestApp
//
//  Created by Roman Rybachenko on 24.01.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation


typealias Completion = () -> Void
typealias FailureHandler = (BTError) -> Void


class WebService {
    static let shared = WebService()
    private init() { }
    
    let baseURL = "https://api.punkapi.com/v2/"
    
    
    func getBeers(with paramters: GetBeersParameters, completion: @escaping ([Beer]) -> Void, failure: @escaping FailureHandler) {
        let apiMethod = APIMethod.getBeers
        
        let urlString = baseURL + apiMethod.rawValue
        var urlComp = URLComponents(string: urlString)
        urlComp?.queryItems = paramters.queryItems
        
        guard let url = urlComp?.url else { failure(BTError.defaultError);  return }
        var request = URLRequest(url: url)
        request.httpMethod = apiMethod.httpMethod
        
        URLSession
            .shared
            .dataTask(with: request,
                      completionHandler: { (data, response, error) in
                        
                        if let data = data {
                            do {
                                let beersArray = try JSONDecoder().decode([Beer].self, from: data)
                                completion(beersArray)
                            } catch let error {
                                pl("decode response error: \n\(error.localizedDescription)")
                                failure(.defaultError)
                            }
                        } else {
                            if let error = error {
                                let httpResponse = response as? HTTPURLResponse
                                let btError = BTError(error: error, statusCode: httpResponse?.statusCode)
                                failure(btError)
                            } else {
                                failure(.defaultError)
                            }
                        }
            })
            .resume()
    }
    
}


enum APIMethod: String {
    case getBeers = "beers"
    
    var httpMethod: String {
        switch self {
        case .getBeers:
            return "GET"
        }
    }
}



