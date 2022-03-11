//
//  MainViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/07.
//

import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var mainModel: [Document]?
    var mainDic: [String: String] = [:] // 가게이름: 썸네일이미지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
        getAPI()
    }
    
    // MARK: 네비게이션 바 설정
    private func setNavigationBar() {
        //let view = UIView()   // leftNavigationBarItem자리
        let searchBtn = makeBtn("magnifyingglass")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        let mapBtn = makeBtn("map")
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mapBtn), spacer,  UIBarButtonItem(customView: searchBtn)]
        
    }
    
    private func makeBtn( _ name: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: name), for: .normal)
        btn.tintColor = .systemGray
        return btn
    }
    
    // MARK: 맛집 컬렉션 뷰
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    // 가게 정보 API 받아오기
    private func getAPI() {
        StoreRequest.getStoreInfo { (mainModel) in
            self.mainModel = mainModel!
            self.getImgAPI()
        }
    }
    
    // 이미지 API 받아오기
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
