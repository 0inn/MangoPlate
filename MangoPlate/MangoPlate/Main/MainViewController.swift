//
//  MainViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/07.
//

import UIKit

import CoreLocation // 현재 위치 받기
import SnapKit
import Then

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var locationManager = CLLocationManager()
    
    var mainModel: [Document]?
    var mainLocation: [[String]] = [[]] // 좌표 (x, y) -> 지도에 마커 찍기 위함
    var mainDic: [String: String] = [:] // 가게이름: 썸네일이미지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLocation()
        setCollectionView()
    }
    
    // MARK: 네비게이션 바 설정
    private func setNavigationBar() {
        //let view = UIView()   // leftNavigationBarItem자리
        let searchBtn = makeBtn("magnifyingglass")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        let mapBtn = makeBtn("map")
        mapBtn.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mapBtn), spacer,  UIBarButtonItem(customView: searchBtn)]
    }
    
    @objc func presentVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.modalPresentationStyle = .fullScreen
        vc.mapLocation = self.mainLocation
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func makeBtn( _ name: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: name), for: .normal)
        btn.tintColor = .systemGray
        return btn
    }
    
    // MARK: 현재 위치
    private func setLocation() {
        locationManager.delegate = self
        // 배터리로 동작할 때 권장되는 가장 높은 수준의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            print("📍위치 서비스 on 상태")
            locationManager.startUpdatingLocation()
            LocationService.shared.latitude = locationManager.location?.coordinate.latitude
            LocationService.shared.latitude = locationManager.location?.coordinate.longitude
            print("📍\(String(describing: locationManager.location?.coordinate))")
        } else {
            print("📍위치 서비스 off 상태")
        }
        getAPI()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("📍위치 update")
        if locations.first != nil {
            LocationService.shared.latitude = locationManager.location?.coordinate.latitude
            LocationService.shared.longtitude = locationManager.location?.coordinate.longitude
        }
    }
    
    // MARK: 맛집 컬렉션 뷰
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    // MARK: 가게 정보 API 받아오기
    private func getAPI() {
        StoreRequest.getStoreInfo { (mainModel) in
            self.mainModel = mainModel!
            for i in 0 ... (mainModel!.count - 1) {
                // cell쪽은 재사용되므로 호출받아온 시점에서 좌표 저장
                self.mainLocation.append([mainModel?[i].y ?? "", mainModel?[i].x ?? ""])
            }
            self.getImgAPI()
        }
    }
    
    // MARK: 이미지 API 받아오기
    private func getImgAPI() {
        for i in 0 ... (mainModel!.count - 1) {
            ImageRequest.getImgInfo(imgName: mainModel![i].place_name!) { (mainImgModel) in
                self.mainDic.updateValue(mainImgModel![0].thumbnail_url ?? "", forKey: self.mainModel![i].place_name!)
                if i == (self.mainModel!.count - 1) { self.collectionView.reloadData() }   // reloadData()하는 시점 생각하기
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        let cellData = mainModel![indexPath.row]
        cell.setData(cellData)
        let cellImg = mainDic[cellData.place_name!]!
        cell.setImg(cellImg)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let numberOfCells: CGFloat = 2
        let width = collectionView.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCells - 1))
        return CGSize(width: width/(numberOfCells), height: width/(numberOfCells) + 100)
    }
}
