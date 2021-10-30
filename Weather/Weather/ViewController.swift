//
//  ViewController.swift
//  Weather
//
//  Created by 윤병일 on 2021/10/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  //MARK: - Properties
  private let cityTextField : UITextField = {
    let tf = UITextField()
    tf.textColor = .black
    tf.layer.borderColor = UIColor.black.cgColor
    tf.layer.borderWidth = 1
    return tf
  }()
  
  private let getWeatherButton : UIButton = {
    let bt  = UIButton()
    bt.setTitle("날씨 가져오기", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(getWeatherBtnTap), for: .touchUpInside)
    return bt
  }()
  
  private let cityLabel : UILabel = {
    let lb = UILabel()
    lb.text = "서울"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    return lb
  }()
  
  private let weatherLabel : UILabel = {
    let lb = UILabel()
    lb.text = "맑음"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    return lb
  }()
  
  private let temperatureLabel : UILabel = {
    let lb = UILabel()
    lb.text = "23.°C"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    return lb
  }()
  
  private let heighestTempLabel : UILabel = {
    let lb = UILabel()
    lb.text = "최고 23.°C"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  private let lowestTempLabel : UILabel = {
    let lb = UILabel()
    lb.text = "최저 23.°C"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    [cityTextField, getWeatherButton, cityLabel, weatherLabel, temperatureLabel, heighestTempLabel, lowestTempLabel].forEach {
      view.addSubview($0)
    }
    
    cityTextField.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(50)
    }
    
    getWeatherButton.snp.makeConstraints {
      $0.top.equalTo(cityTextField.snp.bottom).offset(24)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    cityLabel.snp.makeConstraints {
      $0.top.equalTo(getWeatherButton.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
    }
    
    weatherLabel.snp.makeConstraints {
      $0.top.equalTo(cityLabel.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    
    temperatureLabel.snp.makeConstraints {
      $0.top.equalTo(weatherLabel.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    
    heighestTempLabel.snp.makeConstraints {
      $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview().offset(-50)
    }
    
    lowestTempLabel.snp.makeConstraints {
      $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview().offset(50)
    }
  }
  
  //MARK: - @objc func
  
  @objc func getWeatherBtnTap() {
    print("버튼 클릭됨")
  }


}

