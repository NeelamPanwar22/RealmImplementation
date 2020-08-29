//
//  ListTableViewCell.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import UIKit
import SnapKit

class ListTableViewCell : UITableViewCell {
    
    //MARK:- UI Elements
    private let listDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let productImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let activityIndicator : UIActivityIndicatorView = {
        let indicatiorView = UIActivityIndicatorView(style: .medium)
        return indicatiorView
    }()
    
    //MARK:- Life Cycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        ///ADD UIElements to View
        addSubview(productImage)
        addSubview(listDateLabel)
        addSubview(productDescriptionLabel)
        addSubview(activityIndicator)
        
        
        ///Set UIElement constraints
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        listDateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        let stackView = UIStackView(arrangedSubviews: [productImage,productDescriptionLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 0
        addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.listDateLabel.snp_bottomMargin).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-16)
        }
        productImage.snp.makeConstraints { (make) in
            make.height.equalTo(88.0)
            make.width.equalTo(stackView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public Methods
    func configureCell(listModel : ListDataModel?){
        listDateLabel.text = String(format: "Date : %@", /listModel?.date)
        
        let type = DataListType(rawValue: /listModel?.type)
        
        switch type {
        case .text:
            productImage.isHidden = true
            productDescriptionLabel.isHidden = false
            productDescriptionLabel.text = listModel?.data
        case .image :
            productDescriptionLabel.isHidden = true
            productImage.isHidden = false
            guard let url = URL.init(string: /listModel?.data) else {
                return }
            activityIndicator.startAnimating()
            productImage.load(url: url) { [weak self] (isLoaded) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
            }
        default : break
        }
    }
}
