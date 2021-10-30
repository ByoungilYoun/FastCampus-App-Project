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
    lb.isHidden = true
    lb.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    return lb
  }()
  
  private let weatherLabel : UILabel = {
    let lb = UILabel()
    lb.text = "맑음"
    lb.textColor = .black
    lb.isHidden = true
    lb.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    return lb
  }()
  
  private let temperatureLabel : UILabel = {
    let lb = UILabel()
    lb.text = "23.°C"
    lb.textColor = .black
    lb.isHidden = true
    lb.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    return lb
  }()
  
  private let heighestTempLabel : UILabel = {
    let lb = UILabel()
    lb.text = "최고 23.°C"
    lb.textColor = .black
    lb.isHidden = true
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  private let lowestTempLabel : UILabel = {
    let lb = UILabel()
    lb.text = "최저 23.°C"
    lb.textColor = .black
    lb.isHidden = true
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
  
  func configureView(weatherInformation : WeatherInformation) {
    self.cityLabel.isHidden = false
    self.weatherLabel.isHidden = false
    self.temperatureLabel.isHidden = false
    self.heighestTempLabel.isHidden = false
    self.lowestTempLabel.isHidden = false
    
    self.cityLabel.text = weatherInformation.name
    
    if let weather = weatherInformation.weather.first {
      self.weatherLabel.text = weather.description
    }
    
    self.temperatureLabel.text = "\(Int(weatherInformation.temp.temp - 273.15)) °C"
    self.lowestTempLabel.text = "최저 : \(Int(weatherInformation.temp.minTemp - 273.15)) °C"
    self.heighestTempLabel.text = "최고 : \(Int(weatherInformation.temp.maxTemp - 273.15)) °C"
  }
  
  func showAlert(message : String) {
    let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func getCurrentWeather(cityName : String) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=e59af0787af3b640648647546145a347") else {return}
    let session = URLSession(configuration: .default)
    session.dataTask(with: url) { [weak self] data, response, error in
      let successRange = (200..<300)
      
      guard let data = data, error == nil else {
        return
      }
      
      let decoder = JSONDecoder()
      
      if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
        guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
        
        DispatchQueue.main.async { // 네트워크 작업은 별도의 쓰레드에서 진행되고 응답이 온다 해도 자동으로 메인 쓰레드로 돌아오지 않기때문에 completionHandler 에서 ui 작업을 하게 된다면 메인쓰레드에서 동작하도록 해줘야한다. 
          self?.configureView(weatherInformation: weatherInformation)
        }
      } else { // statusCode 가 200번대 가 아닐때 ErrorMessage 객체로 디코딩
        guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
        
        DispatchQueue.main.async {
          self?.showAlert(message: errorMessage.message)
        }
      }
      
    }.resume()
  }
  
  //MARK: - @objc func
  
  @objc func getWeatherBtnTap() {
    if let cityName = self.cityTextField.text {
      self.getCurrentWeather(cityName: cityName)
      self.view.endEditing(true)
    }
  }
}

