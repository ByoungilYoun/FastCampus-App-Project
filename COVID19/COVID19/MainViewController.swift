//
//  MainViewController.swift
//  COVID19
//
//  Created by 윤병일 on 2021/11/01.
//

import UIKit
import SnapKit
import Charts
import Alamofire

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
    self.fetchCovidOverview(completionHandler: { [weak self] result in // Alamofire 에서 reponseData 메소드의 completionHandler 는 메인스레드에서 동작하기 때문에 따로 메인 dispatchqueue 를 안만들어줘도 된다.
      guard let self = self else { return }
      switch result {
      case let .success(result) :
        self.configureStackView(koreaCovidOverview: result.korea)
        let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
        self.configureChartView(covidOverviewList: covidOverviewList)
      case let .failure(error) :
        debugPrint("failure : \(error)")
      }
    })
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
  
  func fetchCovidOverview (completionHandler : @escaping (Result<CityCovidOverview, Error>) -> Void ) {
    let url = "https://api.corona-19.kr/korea/country/new/"
    let param = [
      "serviceKey" : "LYxOwXBQU4NPWlvhnIeV19EASdj7ZJpy2"
    ]
    
    AF.request(url, method: .get, parameters: param) // 파라미터에 전달하면 알아서 url 뒤에 쿼리 파라미터를 추가해준다.
      .responseData(completionHandler: { response in
        switch response.result {
        case let .success(data) :
          do {
            let decorder = JSONDecoder()
            let result = try decorder.decode(CityCovidOverview.self, from: data)
            completionHandler(.success(result))
          } catch {
            completionHandler(.failure(error))
          }
        case let .failure(error) :
          completionHandler(.failure(error))
        }
      })
  }
  
  func configureStackView(koreaCovidOverview : CovidOverview) {
    self.secondLabel.text = "\(koreaCovidOverview.totalCase) 명"
    self.fourthLabel.text = "\(koreaCovidOverview.newCase) 명"
  }
  
  func makeCovidOverviewList(cityCovidOverview : CityCovidOverview) -> [CovidOverview] {
    return [
      cityCovidOverview.seoul,
      cityCovidOverview.busan,
      cityCovidOverview.daegu,
      cityCovidOverview.incheon,
      cityCovidOverview.gwangju,
      cityCovidOverview.daejeon,
      cityCovidOverview.ulsan,
      cityCovidOverview.sejong,
      cityCovidOverview.gyeonggi,
      cityCovidOverview.chungbuk,
      cityCovidOverview.chungnam,
      cityCovidOverview.gyeongbuk,
      cityCovidOverview.gyeongnam,
      cityCovidOverview.jeju
    ]
  }
  
  func configureChartView(covidOverviewList : [CovidOverview]) {
    self.chartView.delegate = self
    let entries = covidOverviewList.compactMap { [weak self] overView -> PieChartDataEntry? in
      guard let self = self else { return nil }
      return PieChartDataEntry(value: self.removeFormatString(string: overView.newCase), label: overView.countryName, data: overView)
    }
    
    let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
    dataSet.sliceSpace = 1 //항목간 간격을 1피트 떨어지게
    dataSet.entryLabelColor = .black //항목이름 검정색으로
    dataSet.xValuePosition = .outsideSlice // 항목이름이 밖으로
    dataSet.valueTextColor = .black // 항목 안에 있는 값도 검정
    dataSet.valueLinePart1OffsetPercentage = 0.8
    dataSet.valueLinePart1Length = 0.2
    dataSet.valueLinePart2Length = 0.3
    
    dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.liberty() + ChartColorTemplates.pastel() + ChartColorTemplates.material() // 차트 다양한 색상 추가
    
    self.chartView.data = PieChartData(dataSet: dataSet)
    self.chartView.spin(duration: 0.3, fromAngle: self.chartView.rotationAngle, toAngle: self.chartView.rotationAngle + 80) // 차트가 80도 정도 회전
  }
  
  func removeFormatString(string : String) -> Double {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.number(from: string)?.doubleValue ?? 0
  }
}

  //MARK: - ChartViewDelegate
extension MainViewController : ChartViewDelegate {
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    let controller = CovidDetailViewController()
    guard let covidOverview = entry.data as? CovidOverview else {return}
    
    controller.covidOverview = covidOverview
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
