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
        guard let url = URL(string: url) else {
            self.image = UIImage(systemName: "xmark")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data, error == nil else {//데이터와 에러를 체크하여 데이터가 없거나 에러가 있으면 종료
                print("Error: \(error?.localizedDescription ?? "Unknown")")
                return
            }
            
            guard let image = UIImage(data: data) else { return } //url로 받아온 데이터를 통해 UIImage 구성
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()//작업 시작
    }
}
