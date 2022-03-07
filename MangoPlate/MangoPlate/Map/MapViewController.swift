//
//  MapViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/07.
//

import UIKit

public let DEFAULT_POSITION = MTMapPointGeo(latitude: 37.51347450836485, longitude: 126.80474229904588)
class MapViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 지도 불러오기
        mapView = MTMapView(frame: self.view.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            // 지도 중심점, 레벨
            mapView.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION), zoomLevel: 4, animated: true)
            
            // 현재 위치 트래킹
            mapView.showCurrentLocationMarker = true
            mapView.currentLocationTrackingMode = .onWithoutHeading
            
            // 마커 추가
            let poiItem = MTMapPOIItem()
            poiItem.markerType = MTMapPOIItemMarkerType.bluePin
            poiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.51313703458835, longitude: 126.80261503796513))
            poiItem.itemName = "여월휴먼시아 2단지"
            mapView.add(poiItem)
            
            // 원 추가
            let circle = MTMapCircle()
            circle.circleCenterPoint = MTMapPoint(geoCoord: DEFAULT_POSITION)
            circle.circleLineColor = .systemBlue
            circle.circleFillColor = UIColor.init(red: 10, green: 188, blue: 223, alpha: 0.5)
            circle.circleRadius = 3000
            mapView.addCircle(circle)
            
            self.view.addSubview(mapView)
        }
        
    }
    
}

