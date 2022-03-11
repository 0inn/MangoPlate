//
//  ImageRequest.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//

import Alamofire

class ImageRequest {
    
    static func getImgInfo(imgName: String?, completion: @escaping ([ImgDocument]?) -> Void) {
        
        var imgStorage: [ImgDocument]?
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 51302fbcfac8fa678e74120eda31af22"
        ]
        
        let url = "https://dapi.kakao.com/v2/search/image"
        
        let parameters: [String: Any] = [
            "query": imgName ?? "",
            "size": 1
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .responseDecodable(of: ImgInfo.self) { response in
                
                switch response.result {
                case .success(let response):
                    print("📸 이미지 API 호출")
                    imgStorage = response.documents
                    completion(imgStorage!)
                    
                case .failure(let error):
                    print("DEBUG>> ERROR: \(error.localizedDescription)")
                }
            }
        
    }
    
}
