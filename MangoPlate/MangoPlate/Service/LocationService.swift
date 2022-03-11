//
//  LocationModel.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/11.
//

import Foundation

// 싱글톤 사용하여 현재 좌표 저장
class LocationService {
    static var shared = LocationService()
    var longtitude: Double?
    var latitude: Double?
}
