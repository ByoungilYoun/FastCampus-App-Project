//
//  MainViewController.swift
//  SpotifyLoginPage
//
//  Created by 윤병일 on 2021/09/16.
//

import UIKit
import FirebaseAuth

class MainViewController : UIViewController {
  
  //MARK: - Properties
  private let welcomeLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.numberOfLines = 0
    return label
  }()
  
  private let logoutButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("로그아웃", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  private let resetPasswordButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("비밀번호 변경", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.addTarget(self, action: #selector(findPasswordBtnTapped), for: .touchUpInside)
    bt.isHidden = true
    return bt
  }()
  
  private let updateNickNameButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("닉네임 업데이트", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.addTarget(self, action: #selector(updateNickNameBtnTapped), for: .touchUpInside)
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
    navigationController?.navigationBar.isHidden = true
    setWelcomLabelText()
    showResetPasswordButtonOrNot()
  }
  
  //MARK: - Functions
  private func configureNavi() {
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false // 네비게이션 뒤로가는 팝 제스쳐 막기
  }
  
  private func configureUI() {
    view.backgroundColor = .black
    
    [welcomeLabel, logoutButton, resetPasswordButton, updateNickNameButton].forEach {
      view.addSubview($0)
    }
    
    welcomeLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    logoutButton.snp.makeConstraints {
      $0.top.equalTo(welcomeLabel.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
    }
    
    resetPasswordButton.snp.makeConstraints {
      $0.top.equalTo(logoutButton.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    
    updateNickNameButton.snp.makeConstraints {
      $0.top.equalTo(logoutButton.snp.bottom).offset(40)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func setWelcomLabelText() {
    let email = Auth.auth().currentUser?.email ?? "고객"
    welcomeLabel.text = """
      환영합니다.
      \(email)님
      """
  }
  
  private func showResetPasswordButtonOrNot() {
    let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
    resetPasswordButton.isHidden = !isEmailSignIn
  }
  
  //MARK: - @objc func
  @objc private func logoutBtnTapped() {
    let firebaseAuth = Auth.auth()
    
    do {
      try firebaseAuth.signOut()
      // 에러가 발생하지 않으면 pop
      self.navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error : signOut \(signOutError.localizedDescription)")
    }
  }
  
  @objc private func findPasswordBtnTapped() {
    let email = Auth.auth().currentUser?.email ?? ""
    Auth.auth().sendPasswordReset(withEmail: email, completion: nil) // 현재 사용자가 가지고있는 이메일로 비밀번호를 리셋할수 있는 이메일을 보낸다.
  }
  
  @objc private func updateNickNameBtnTapped() {
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.displayName = "애플로그인"
    changeRequest?.commitChanges { _ in
      let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객님"
      self.welcomeLabel.text = """
        환영합니다.
        \(displayName)님
        """
    }
  }
}
