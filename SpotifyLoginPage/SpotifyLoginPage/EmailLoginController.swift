//
//  EmailLoginController.swift
//  SpotifyLoginPage
//
//  Created by 윤병일 on 2021/09/16.
//

import UIKit

class EmailLoginController : UIViewController {
  
  
  //MARK: - Properties
  private let emailLabel : UILabel = {
    let label = UILabel()
    label.text = "이메일"
    label.textAlignment = .left
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .white
    return label
  }()

  let emailTextField : UITextField  = {
    let tf = UITextField()
    tf.layer.borderWidth = 1
    tf.layer.borderColor = UIColor.white.cgColor
    return tf
  }()
  
  private let passwordLabel : UILabel = {
    let label = UILabel()
    label.text = "비밀번호"
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  
  
  let passwordTextField : UITextField  = {
    let tf = UITextField()
    tf.layer.borderWidth = 1
    tf.layer.borderColor = UIColor.white.cgColor
    tf.isSecureTextEntry = true
    return tf
  }()
  
  let nextButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("다음", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavi()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - Functions
  private func configureNavi() {
    title = "이메일/비밀번호 입력하기"
    navigationController?.navigationBar.tintColor = .white
  }
  
  
  private func configureUI() {
    view.backgroundColor = .black
    
    [emailLabel, emailTextField, passwordLabel, passwordTextField].forEach {
      $0.snp.makeConstraints {
        $0.height.equalTo(40)
      }
    }
    
    let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
    emailStackView.axis = .vertical
    emailStackView.distribution = .fill
    emailStackView.spacing = 5
    
    let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
    passwordStackView.axis = .vertical
    passwordStackView.distribution = .fill
    passwordStackView.spacing = 5
    
    let totalStackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView])
    totalStackView.axis = .vertical
    totalStackView.distribution = .fill
    totalStackView.spacing = 5
    
    view.addSubview(totalStackView)
    totalStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
    }
    
    view.addSubview(nextButton)
    nextButton.snp.makeConstraints {
      $0.top.equalTo(totalStackView.snp.bottom).offset(40)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(80)
      $0.height.equalTo(50)
    }
  }
  
  
  //MARK: - @objc func
  @objc func nextBtnTapped() {
    print("1234")
  }
}

