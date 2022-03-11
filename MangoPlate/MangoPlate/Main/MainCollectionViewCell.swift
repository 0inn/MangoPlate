//
//  MainCollectionViewCell.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDist: UILabel!
    @IBOutlet weak var storeScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setData( _ data: Document) {
        storeName.text = data.place_name
        let dist = Double(data.distance!)! / Double(1000)
        let distStr = String(format: "%.2f", dist)
        storeDist.text = "부천시 \(distStr) km"
    }
    
    public func setImg( _ data: String) {
        // 이미지 큰 거 받아올 때, 멈춤 생길 수 있으므로 멀티 쓰레드로 작동하게 구현 -> 오히려 오래 걸림 ^^
//        DispatchQueue.global().async {
//            let url = URL(string: data)
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                self.storeImg.image = UIImage(data: data!)
//            }
//        }
        let url = URL(string: data)
        let data = try? Data(contentsOf: url!)
        storeImg.image = UIImage(data: data!)
    }

}
