//
//  LoginViewController.swift
//  SpotifyLoginPage
//
//  Created by 윤병일 on 2021/09/15.
//

import UIKit
import SnapKit
import GoogleSignIn
import AuthenticationServices
import FirebaseAuth
import CryptoKit // 해시값 추가를 위해

class LoginViewController : UIViewController {
  
  //MARK: - Properties
  
  fileprivate var currentNonce: String?
  
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
    bt.layer.borderWidth = 1
    bt.layer.borderColor = UIColor.white.cgColor
    bt.layer.cornerRadius = 10
    bt.addTarget(self, action: #selector(emailLoginBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  let googleLoginButton : GIDSignInButton = {
    let bt = GIDSignInButton()
    bt.layer.cornerRadius = 10
    bt.addTarget(self, action: #selector(googleLoginBtnTapped), for: .touchUpInside)
    return bt
  }()
  
  let appleLoginButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("애플로 계속하기", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    bt.setImage(UIImage(named: "logo_apple"), for: .normal)
    bt.layer.borderWidth = 1
    bt.layer.borderColor = UIColor.white.cgColor
    bt.layer.cornerRadius = 10
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
    
    // Google Sign In
    GIDSignIn.sharedInstance().presentingViewController = self
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
    GIDSignIn.sharedInstance().signIn()
  }
  
  @objc private func appleLoginBtnTapped() {
    startSignInWithAppleFlow()
  }
}

//MARK: - extension ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      //      /*
      //       Nonce 란?
      //       - 암호화된 임의의 난수
      //       - 단 한번만 사용할 수 있는 값
      //       - 주로 암호화 통신을 할 때 활용
      //       - 동일한 요청을 짧은 시간에 여러번 보내는 릴레이 공격 방지
      //       - 정보 탈취 없이 안전하게 인증 정보 전달을 위한 안전장치
      //       */
      guard let nonce = currentNonce else {
        fatalError("Invalid state: A login callback was received, but no login request was sent.")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
      
      let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
      
      Auth.auth().signIn(with: credential) { authResult, error in
        if let error = error {
          print ("Error Apple sign in: %@", error)
          return
        }
        // User is signed in to Firebase with Apple.
        // ...
        ///Main 화면으로 보내기
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
      }
    }
  }
}

//Apple Sign in
extension LoginViewController {
  func startSignInWithAppleFlow() {
    let nonce = randomNonceString()
    currentNonce = nonce
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    request.nonce = sha256(nonce)
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
      return String(format: "%02x", $0)
    }.joined()
    
    return hashString
  }
  
  
  private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
      let randoms: [UInt8] = (0 ..< 16).map { _ in
        var random: UInt8 = 0
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
        if errorCode != errSecSuccess {
          fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        return random
      }
      
      randoms.forEach { random in
        if remainingLength == 0 {
          return
        }
        
        if random < charset.count {
          result.append(charset[Int(random)])
          remainingLength -= 1
        }
      }
    }
    
    return result
  }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}
