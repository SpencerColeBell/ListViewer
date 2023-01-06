//
//  ListDetailData.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import Foundation

struct ListDetailData {
    let listItems: [String]
}

extension ListDetailData {
    init(catBreedsData: CatBreedsData) {
        self.listItems = catBreedsData.data.map({
            "Breed   : \($0.breed ?! "N/A")\nCountry : \($0.country ?! "N/A")\nOrigin  : \($0.origin ?! "N/A")\nCoat    : \($0.coat ?! "N/A")\nPattern : \($0.pattern ?! "N/A")"
        })
    }
}

extension ListDetailData {
    init(catFactsData: CatFactsData) {
        self.listItems = catFactsData.data.map { $0.fact }
    }
}

// For some of the String data in the API, I was getting back an empty string. I decided to handle this in an identical
// manner to an optional that is nil
extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

infix operator ?!

func ?! <T> (wrappedValue: T?, defaultValue: @autoclosure () -> T) -> T where T: Collection {
    // swiftlint:disable force_unwrapping
    wrappedValue.isNilOrEmpty ? defaultValue() : wrappedValue!
}
