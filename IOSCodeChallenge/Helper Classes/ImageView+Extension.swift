//
//  ImageView+Extension.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 29/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL , callBack : (( _ imageLoaded : Bool) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        callBack?(true)
                    }
                }
            }else{
                callBack?(false)
            }
        }
    }
}

