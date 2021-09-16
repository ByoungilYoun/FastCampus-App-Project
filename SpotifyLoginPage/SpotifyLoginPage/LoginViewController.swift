//
//  LoginViewController.swift
//  SpotifyLoginPage
//
//  Created by 윤병일 on 2021/09/15.
//

import UIKit
import SnapKit

class LoginViewController : UIViewController {
  
  //MARK: - Properties
  
  private let myImageView : UIImageView = {
    let v = UIImageView()
    v.image = UIImage(systemName: "music.house.fill")
    v.tintColor = .white
    return v
  }()
  
  private let mainLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 31)
    label.numberOfLines = 3
    label.text = "내 마음에 꼭 드는 또 다른 플레이리스트를 발견해보세요."
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  let emailLoginButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("이메일/비밀번호로 계속하기", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.addTarget(self, action: #selector(emailLoginBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  let googleLoginButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("구글로 계속하기", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.setImage(UIImage(named: "logo_google"), for: .normal)
    bt.addTarget(self, action: #selector(googleLoginBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  let appleLoginButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("애플로 계속하기", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.setImage(UIImage(named: "logo_apple"), for: .normal)
    bt.addTarget(self, action: #selector(appleLoginBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .black
    
    myImageView.snp.makeConstraints {
      $0.height.equalTo(80)
      $0.width.equalTo(70)
    }
    
    let firstStackView = UIStackView(arrangedSubviews: [myImageView, mainLabel])
    firstStackView.axis = .vertical
    firstStackView.alignment = .center
    firstStackView.distribution = .fill
    firstStackView.spacing = 10
    
    view.addSubview(firstStackView)
    firstStackView.snp.makeConstraints {
      $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(-(UIScreen.main.bounds.height / 5))
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerX.equalToSuperview()
    }
    
    [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
      $0.snp.makeConstraints {
        $0.height.equalTo(60)
      }
      
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.white.cgColor
      $0.layer.cornerRadius = 30
    }
    
    
    let secondStackView = UIStackView(arrangedSubviews: [emailLoginButton, googleLoginButton, appleLoginButton])
    secondStackView.axis = .vertical
    secondStackView.distribution = .fillEqually
    secondStackView.spacing = 15
    
    view.addSubview(secondStackView)
    secondStackView.snp.makeConstraints {
      $0.top.equalTo(firstStackView.snp.bottom).offset(80)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.centerX.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  @objc private func emailLoginBtnTapped() {
    let vc = EmailLoginController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc private func googleLoginBtnTapped() {
    
  }
  
  @objc private func appleLoginBtnTapped() {
    
  }
}
