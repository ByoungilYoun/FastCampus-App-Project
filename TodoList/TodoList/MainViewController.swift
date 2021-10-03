//
//  MainViewController.swift
//  TodoList
//
//  Created by 윤병일 on 2021/10/03.
//

import UIKit
import SnapKit

class MainViewController : UIViewController {
  
  //MARK: - Properties
  
  private let todoListTableView = UITableView()
  
  var tasks = [Task]() {
    didSet {
      self.saveTasks()
    }
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavi()
    self.loadTasks()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    todoListTableView.dataSource = self
    todoListTableView.delegate = self
    todoListTableView.tableFooterView = UIView()
    todoListTableView.backgroundColor = .white
    todoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(todoListTableView)
    
    todoListTableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    
  }
  
  private func configureNavi() {
    let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editBtnTapped))
    editButton.tintColor = .black
    navigationItem.leftBarButtonItem = editButton
    
    let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBtnTapped))
    plusButton.tintColor = .black
    navigationItem.rightBarButtonItem = plusButton
  }
  
  func saveTasks() {
    let data = self.tasks.map {
      [
        "title" : $0.title,
        "done" : $0.done
      ]
    }
    
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: "tasks")
  }
  
  func loadTasks() {
    let userDefaults = UserDefaults.standard
    guard let data = userDefaults.object(forKey: "tasks") as? [[String : Any]] else {return}
    self.tasks = data.compactMap {
      guard let title = $0["title"] as? String else { return nil }
      guard let done = $0["done"] as? Bool else {return nil }
      return Task(title: title, done: done)
    }
  }
  
  //MARK: - @objc func
  @objc func editBtnTapped() {
    
  }
  
  @objc func plusBtnTapped() {
    let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
    let registerButton = UIAlertAction(title: "등록", style: .default) { [weak self] _ in
      guard let title = alert.textFields?[0].text else {return}
      
      let task = Task(title: title, done: false)
      self?.tasks.append(task)
      self?.todoListTableView.reloadData()
    }
    
    let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    alert.addAction(cancelButton)
    alert.addAction(registerButton)
    alert.addTextField { textfField in
      textfField.placeholder = "할 일을 입력해주세요."
    }
    self.present(alert, animated: true, completion: nil)
  }
}

  //MARK: - UITableViewDataSource
extension MainViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let task = self.tasks[indexPath.row]
    cell.textLabel?.text = task.title
    cell.textLabel?.textColor = .black
    cell.backgroundColor = .white
    cell.selectionStyle = .none
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension MainViewController : UITableViewDelegate {
  
}
