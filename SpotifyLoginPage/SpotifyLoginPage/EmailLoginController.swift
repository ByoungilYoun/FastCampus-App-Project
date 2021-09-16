//
//  EmailLoginController.swift
//  SpotifyLoginPage
//
//  Created by 윤병일 on 2021/09/16.
//

import UIKit
import FirebaseAuth

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
    tf.backgroundColor = .white
    tf.textColor = .black
    tf.layer.cornerRadius = 10
    tf.keyboardType = .emailAddress
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
    tf.backgroundColor = .white
    tf.textColor = .black
    tf.isSecureTextEntry = true
    tf.layer.cornerRadius = 10
    return tf
  }()
  
  let errorMessageLabel : UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .red
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 18)
    return label
  }()
  
  let nextButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("다음", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.backgroundColor = .white
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.layer.cornerRadius = 10
    bt.isEnabled = false
    bt.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavi()
    configureUI()
    setTextFieldDelegate()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
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
    
    [totalStackView, errorMessageLabel, nextButton].forEach {
      view.addSubview($0)
    }
    
    totalStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
    }
    
    errorMessageLabel.snp.makeConstraints {
      $0.top.equalTo(totalStackView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(totalStackView)
    }
    
    nextButton.snp.makeConstraints {
      $0.top.equalTo(errorMessageLabel.snp.bottom).offset(50)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(80)
      $0.height.equalTo(50)
    }
  }
  
  private func setTextFieldDelegate() {
    emailTextField.becomeFirstResponder()
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  private func showMainViewController() {
    let vc = MainViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func loginUser(withEmail email : String, password : String) {
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
      guard let self = self else { return }
      
      if let error = error {
        self.errorMessageLabel.text = error.localizedDescription
      } else {
        self.showMainViewController()
      }
    }
  }
  
  //MARK: - @objc func
  @objc func nextBtnTapped() {
    // Firebase 이메일/비밀번호 인증하는 곳
    let email = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    
    // 신규 사용자 생성
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
      guard let self = self else { return }
      
      if let error = error {
        let code = (error as NSError).code
        
        switch code {
        case 17007: // 이미 가입한 계정일때는 로그인 함수를 만들어서 로그인을 하도록 한다.
          self.loginUser(withEmail: email, password: password)
        default:
          self.errorMessageLabel.text = error.localizedDescription
        }
      } else {
        self.showMainViewController()
      }
    }
  }
}

  //MARK: - extension UITextFieldDelegate
extension EmailLoginController : UITextFieldDelegate {
  // 리턴 버튼을 눌렀을때 키보드 내리기
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    let isEmailEmpty = emailTextField.text == ""
    let isPasswordEmpty = passwordTextField.text == ""
    
    nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
  }
}
