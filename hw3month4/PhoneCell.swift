//
//  PhoneCell.swift
//  hw3month4
//
//  Created by Nurjamal Mirbaizaeva on 18/4/23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class PhoneCell: UICollectionViewCell {
    
    static var reuseId = "phone_cell"
    
    private lazy var phoneImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var phoneTitleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var phoneDescriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
        setupSubviews()
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    func fill(phone: Phone){
        phoneImageView.kf.setImage(with: URL(string: phone.image_url))
        phoneTitleLabel.text = phone.name
        phoneDescriptionLabel.text = phone.description
    }
    func setupSubviews(){
        addSubview(phoneImageView)
        phoneImageView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(300)
        }
        addSubview(phoneTitleLabel)
        phoneTitleLabel.snp.makeConstraints {make in
            make.top.equalTo(phoneImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        addSubview(phoneDescriptionLabel)
        phoneDescriptionLabel.snp.makeConstraints {make in
            make.top.equalTo(phoneTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
