//
//  CatModels.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/4/23.
//

import Foundation

struct CatLinkData: Codable {
    let url: String?
    let label: String
    let active: Bool
}


struct CatBreedData: Codable {
    let breed: String?
    let country: String?
    let origin: String?
    let coat: String?
    let pattern: String?
}

struct CatBreedsData: Codable {
    let current_page: Int
    let data: [CatBreedData]
    let links: [CatLinkData]
    let next_page_url: String?
    let path: String?
    let per_page: Int?
    let prev_page_url: String?
    let to: Int?
    let total: Int?
}

struct CatFactData: Codable {
    let fact: String
    let length: Int
}

struct CatFactsData: Codable {
    let current_page: Int
    let data: [CatFactData]
    let links: [CatLinkData]
    let next_page_url: String?
    let path: String?
    let per_page: Int?
    let prev_page_url: String?
    let to: Int?
    let total: Int?
}
