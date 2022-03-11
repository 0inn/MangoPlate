//
//  MapViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/11.
//

import UIKit

import NMapsMap
import SnapKit

class MapViewController: UIViewController {
    
    let mapView = NMFMapView()
    var mapLocation: [[String]] = [[]]  // 음식점 좌표(x, y) 받아옴
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMap()
        setCamera()
        setMarker()
        print("🗺 \(mapLocation[1][0]) \(mapLocation[1][1])")
    }
    
    // MARK: 네비게이션 바 설정
    private func setNavigationBar() {
        //let view = UIView()   // leftNavigationBarItem자리
        let searchBtn = makeBtn("magnifyingglass")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        let mapBtn = makeBtn("line.3.horizontal")
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mapBtn), spacer,  UIBarButtonItem(customView: searchBtn)]
        
    }
    
    private func makeBtn( _ name: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: name), for: .normal)
        btn.tintColor = .systemGray
        return btn
    }
    
    // MARK: 지도뷰 크기 및 위치 설정
    private func setMap() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints() {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: 중심점 잡기
    private func setCamera() {
        print("🧭 \(LocationService.shared.latitude!)")
        print("🧭 \(LocationService.shared.longtitude!)")
        let camPosition = NMGLatLng(lat: 37.51189220888594, lng: 126.8010862383141)
        let camUpdate = NMFCameraUpdate(scrollTo: camPosition)
        mapView.moveCamera(camUpdate)
    }
    
    // MARK: 음식점 마커 (+ 이미지 커스텀)
    private func setMarker() {
        let image = NMFOverlayImage(name: "음식점")
        for i in 1 ... (mapLocation.count - 1) {
            let marker = NMFMarker()
            marker.iconImage = image
            marker.iconTintColor = .red
            let x = Double(mapLocation[i][0])
            let y = Double(mapLocation[i][1])
            marker.position = NMGLatLng(lat: x! , lng: y!)
            marker.width = 40
            marker.height = 50
            marker.mapView = mapView
        }
    }
}
