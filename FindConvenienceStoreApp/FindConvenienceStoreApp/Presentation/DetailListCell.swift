//
//  DetailListCell.swift
//  FindConvenienceStoreApp
//
//  Created by 윤병일 on 2021/12/28.
//

import UIKit

class DetailListCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "DetailListCell"
  
  let placeNameLabel = UILabel()
  let addressLabel = UILabel()
  let distanceLabel = UILabel()
  
  //MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func attribute() {
    backgroundColor = .white
    placeNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
    placeNameLabel.textColor = .black
    
    addressLabel.font = .systemFont(ofSize: 14)
    addressLabel.textColor = .gray
    
    distanceLabel.font = .systemFont(ofSize: 12, weight : .light)
    distanceLabel.textColor = .darkGray
  }
  
  private func layout() {
    [placeNameLabel, addressLabel, distanceLabel].forEach {
      contentView.addSubview($0)
    }
    
    placeNameLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(12)
      $0.leading.equalToSuperview().offset(18)
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalTo(placeNameLabel.snp.bottom).offset(3)
      $0.leading.equalTo(placeNameLabel)
      $0.bottom.equalToSuperview().inset(12)
    }
    
    distanceLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(20)
    }
  }
  
  func setData(_ data : DetailListCellData) {
    placeNameLabel.text = data.placeName
    
    placeNameLabel.text = data.address
    placeNameLabel.text = data.distance
  }
}
