//
//  APICaller.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import Foundation

enum APIListCallerEndpoint {
    case catBreeds
    case catFacts
    
    var url: URL? {
        switch self {
        case .catBreeds:
            return URL(string: "https://catfact.ninja/breeds")
        case .catFacts:
            return URL(string: "https://catfact.ninja/facts")
        }
    }
}

protocol APIListCallerProtocol {
    func fetchListDetailData<T: Codable>(rawDataType: T.Type, url: URL, completion: @escaping (T?, Error?) -> Void)
}

class APIListCaller: APIListCallerProtocol {
    func fetchListDetailData<T: Codable>(rawDataType: T.Type, url: URL, completion: @escaping (T?, Error?) -> Void) {
        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let rawListData = try? JSONDecoder().decode(rawDataType, from: data) {
                    print(rawListData)
                    completion(rawListData, nil)
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
