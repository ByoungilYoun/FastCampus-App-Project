//
//  MainViewController.swift
//  COVID19
//
//  Created by 윤병일 on 2021/11/01.
//

import UIKit
import SnapKit
import Charts

class MainViewController : UIViewController {
  
  //MARK: - Properties
  private let firstLabel : UILabel = {
    let lb = UILabel()
    lb.text = "국내 확진자"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  private let secondLabel : UILabel = {
    let lb = UILabel()
    lb.text = "하하"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  private let thirdLabel : UILabel = {
    let lb = UILabel()
    lb.text = "국내 신규 확진자"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  private let fourthLabel : UILabel = {
    let lb = UILabel()
    lb.text = "하하"
    lb.textColor = .black
    lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    return lb
  }()
  
  private let chartView : PieChartView = {
    let v = PieChartView()
    return v
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavigation()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    let firstStack = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
    firstStack.axis = .vertical
    firstStack.distribution = .fillEqually
    firstStack.alignment = .center
    firstStack.spacing = 20
    
    let secondStack = UIStackView(arrangedSubviews: [thirdLabel, fourthLabel])
    secondStack.axis = .vertical
    secondStack.distribution = .fillEqually
    secondStack.alignment = .center
    secondStack.spacing = 20
    
    let finalStack = UIStackView(arrangedSubviews: [firstStack, secondStack])
    finalStack.axis = .horizontal
    finalStack.distribution = .fillEqually
    finalStack.spacing = 0
    finalStack.alignment = .center
    
    [finalStack, chartView].forEach {
      view.addSubview($0)
    }
    
    finalStack.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
    
    chartView.snp.makeConstraints {
      $0.top.equalTo(finalStack.snp.bottom).offset(24)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.bottom.equalToSuperview().offset(-24)
    }
  }
  
  private func configureNavigation() {
    let appearance = UINavigationBarAppearance()
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }
  //MARK: - @objc func
  
}
