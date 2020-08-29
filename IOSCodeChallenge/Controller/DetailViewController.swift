//
//  DetailViewController.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 29/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK:- Private Properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let detailLabel = UILabel()
    private let indicatiorView = UIActivityIndicatorView(style: .medium)
    
    //MARK:- Public Properties
    var listData : ListDataModel?
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setUpData()
    }
}

//MARK:- View Controller Methods
extension DetailViewController {
    
    private func setUI(){
        self.view.backgroundColor = .white
        
        //Add and setup scroll view
        self.view.addSubview(self.scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //Constrain scroll view
        self.scrollView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.view.snp.top).offset(24)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            
        }
        
        self.view.addSubview(indicatiorView)
        
        indicatiorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        //Add and setup stack view
        self.scrollView.addSubview(self.stackView)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isScrollEnabled = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 0
        
        
        self.stackView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            
        }
        
        //constrain width of stack view to width of self.view, NOT scroll view
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor , constant: -40 ).isActive = true
        
        //Add Label and Image to StackView
        self.stackView.addArrangedSubview(detailLabel)
        self.stackView.addArrangedSubview(imageView)
        
        detailLabel.numberOfLines = 0
        detailLabel.textColor = .gray
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textAlignment = .left
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width).offset(-40)
            make.height.equalTo(self.view.snp.height).offset(-40)
        }
        
    }
    //Set Up View Data
    private func setUpData(){
        let type = DataListType(rawValue: /listData?.type)
        
        switch type {
        case .text:
            imageView.isHidden = true
            detailLabel.isHidden = false
            detailLabel.text = listData?.data
        case .image:
            detailLabel.isHidden = true
            imageView.isHidden = false
            guard let imgUrlString = listData?.data ,
                let url = URL.init(string: imgUrlString) else { return}
            indicatiorView.startAnimating()
            imageView.load(url: url) { [weak self] (isLoaded) in
                DispatchQueue.main.async {
                    self?.indicatiorView.stopAnimating()
                }
            }
        default: break
        }
    }
}
