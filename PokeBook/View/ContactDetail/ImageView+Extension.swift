//
//  ImageView+Extension.swift
//  PokeBook
//
//  Created by 박진홍 on 12/12/24.
//
//DetailView에서만 사용되는 확장이기에 DetailView와 같은 폴더에 위치시킴
import UIKit

extension UIImageView {
    func setImage(url: String) {
        if let cachedImage = ImageCacheManager.shared.getImage(for: url) {//cash 체크
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else {//캐시 없을 때는 네트워크로 요청
            self.image = UIImage(systemName: "person.circle")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in//간단한 요청이므로 URLSesison을 따로 만들지 않고 공유세션 사용
            guard let self = self else { return }
            guard let data, error == nil else {//데이터와 에러를 체크하여 데이터가 없거나 에러가 있으면 종료
                print("Error: \(error?.localizedDescription ?? "Unknown")")
                return
            }
            guard let image = UIImage(data: data) else {//data를 기반으로 이미지 만들기 시도
                print("failed to load image: \(error?.localizedDescription ?? "Unknown")")
                return
            }
            
            ImageCacheManager.shared.saveImage(image, for: url.absoluteString)//다운로드한 이미지는 캐시로 저장하기
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()//작업 시작
    }
}
