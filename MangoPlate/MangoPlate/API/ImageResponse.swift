//
//  ImageResponse.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//

import Foundation

// MARK: - ImgInfo
struct ImgInfo: Codable {
    let documents: [ImgDocument]?
    let meta: ImgMeta?
}

// MARK: - Document
struct ImgDocument: Codable {
    let collection: String?
    let datetime: String?
    let display_sitename: String?
    let doc_url: String?
    let height: Int?
    let image_url: String?
    let thumbnail_url: String?
    let width: Int?
}

// MARK: - Meta
struct ImgMeta: Codable {
    let is_end: Bool?
    let pageable_count, total_count: Int?
}
