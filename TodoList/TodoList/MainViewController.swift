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
  
  var editButton = UIBarButtonItem()
  var doneButton = UIBarButtonItem()
  
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
    editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editBtnTapped))
    editButton.tintColor = .black
    navigationItem.leftBarButtonItem = editButton
    
    doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnTapped))
    
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
    guard !self.tasks.isEmpty else { return } // tasks 배열이 비어있지 않을때만 편집 모드로 전환되게 방어 코드 작성
    self.navigationItem.leftBarButtonItem = self.doneButton
    self.todoListTableView.setEditing(true, animated: true) // 테이블뷰가 편집모드로 전환되게끔 구현
  }
  
  @objc func doneBtnTapped() {
    self.navigationItem.leftBarButtonItem = self.editButton
    self.todoListTableView.setEditing(false, animated: true)
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
    
    if task.done {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
    return cell
  }
  
  // 편집모드에서 삭제버튼을 눌렀을때 삭제버튼이 눌러진 셀이 어떤 셀인지 알려주는 메서드
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    self.tasks.remove(at: indexPath.row)
    self.todoListTableView.deleteRows(at: [indexPath], with: .automatic)
    
    if self.tasks.isEmpty { // 만약 task 가 비어있다면 done 버튼 눌러짐으로써 빠져나오게끔 구현
      self.doneBtnTapped()
    }
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // 행이 다른 위치로 이동하면 sourceIndexPath 파라미터를 통해 원래 있었던 위치를 알려주고 destinationIndexPath 파라미터를 통해 어디로 이동했는지 알려준다.
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    var tasks = self.tasks
    let task = tasks[sourceIndexPath.row]
    tasks.remove(at: sourceIndexPath.row)
    tasks.insert(task, at: destinationIndexPath.row)
    self.tasks = tasks
  }
}

  //MARK: - UITableViewDelegate
extension MainViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var task = self.tasks[indexPath.row]
    task.done = !task.done
    self.tasks[indexPath.row] = task
    self.todoListTableView.reloadRows(at: [indexPath], with: .automatic) // 선택된 셀만 리로드
  }
}
