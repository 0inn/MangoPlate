//
//  MyPageViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/11.
//

import UIKit

class MyPageViewController: UIViewController{
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfile()
        setImageCircle()
    }
    
    private func setProfile() {
        // 프로필 이미지
        let url = UserDefaults.standard.url(forKey: "profileImg")
        let img = try? Data(contentsOf: url!)
        profileImg.image = UIImage(data: img!)
        // 이름
        name.text = UserDefaults.standard.string(forKey: "name")
    }
    
    private func setImageCircle() {
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
    }
    
}
