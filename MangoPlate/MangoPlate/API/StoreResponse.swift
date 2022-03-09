//
//  StoreResponse.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//


import Foundation

// MARK: - StoreInfo
struct StoreInfo: Codable {
    let documents: [Document]?
    let meta: Meta?
}

// MARK: - Document
struct Document: Codable {
    let address_name: String?
    let category_group_code: String?
    let category_group_name: String?
    let category_name, distance, id, phone: String?
    let place_name: String?
    let place_url: String?
    let road_address_name, x, y: String?
}

// MARK: - Meta
struct Meta: Codable {
    let is_end: Bool?
    let pageable_count: Int?
    let same_name: Bool?
    let total_count: Int?
}
