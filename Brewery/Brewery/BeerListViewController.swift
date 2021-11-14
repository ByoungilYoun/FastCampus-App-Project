//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 윤병일 on 2021/11/14.
//

import UIKit

class BeerListViewController : UIViewController {

  var beerList = [Beer]()
  var dataTasks = [URLSessionTask]() // 이미 한번 한 dataTask 저장 배열
  
  var currentPage = 1 // 페이지별로 데이터를 불러올거다.
  
  let beerListTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.configureNavigation()
    self.fetchBeer(of: currentPage)
  }
  
  //MARK: - Functions
  private func configureNavigation() {
    title = "패캠브루어리"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureUI() {
    view.backgroundColor = .white
    //UITableView 설정
    
    beerListTableView.delegate = self
    beerListTableView.dataSource = self
    beerListTableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
    beerListTableView.rowHeight = 150
    beerListTableView.prefetchDataSource = self // 다음 데이터를 가져오기 위한 페이지 네이션 delegate 선언
    
    view.addSubview(beerListTableView)
    
    beerListTableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}


  //MARK: - extension UITableView Datasource, Delegate
extension BeerListViewController : UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return beerList.count
  }
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell()}
    let beer = beerList[indexPath.row]
    cell.configure(with: beer)
    return cell
  }
  
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedBeer = beerList[indexPath.row]
    let detailViewController = BeerDetailViewController()
    detailViewController.beer = selectedBeer
    self.show(detailViewController, sender: nil)
  }
}

  //MARK: - UITableViewDataSourcePrefetching - 미리 불러오는 역할
extension BeerListViewController : UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
      guard currentPage != 1 else { // 페이지가 1번이면 이미 했기때문에 할 필요가 없다.
        return
      }
    
    indexPaths.forEach {
      if ($0.row + 1) / 25 + 1 == currentPage {
        self.fetchBeer(of: currentPage)
      }
    }
  }
}


private extension BeerListViewController {
  func fetchBeer(of page : Int) {
    guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
    dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil // 데이터 테스크 안에 있는 요청된 url 이 새롭게 url 에 없어야한다. 새로운 값이여야 한다. 이미 있다면 한번 요청한것이기 때문에
  else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      guard error == nil,
            let self = self,
            let response = response as? HTTPURLResponse,
            let data = data,
            let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
              print("Error : URLSession data task \(error?.localizedDescription ?? "")")
              return
            }
      switch response.statusCode {
      case (200...299) : // 성공
        print("성공")
        
        self.beerList += beers //배열에 넣어줘
        self.currentPage += 1 // 페이지 업
        print("성공 : \(self.beerList)")
        DispatchQueue.main.async {
          self.beerListTableView.reloadData()
        }
      case (400...499) : // 클라이언트 에러
        print("""
          Error : Client Error \(response.statusCode)
          Response : \(response)
      """)
      case (500...599) : // 서버 에러
        print("""
          Error : Server Error \(response.statusCode)
          Response : \(response)
      """)
      default :
        print("""
          Error : \(response.statusCode)
          Response : \(response)
      """)
      }
    }
    dataTask.resume() //데이터 task 실행
    dataTasks.append(dataTask) //한번 실행한 dataTask 는 저장
  }
}
