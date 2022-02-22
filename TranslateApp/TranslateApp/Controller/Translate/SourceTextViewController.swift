//
//  SourceTextViewController.swift
//  TranslateApp
//
//  Created by 윤병일 on 2022/02/21.
//

import UIKit

protocol SourceTextViewControllerDelegate : AnyObject {
  func didEnterText(_ sourceText : String)
}

final class SourceTextViewController : UIViewController {
  
  //MARK: - Properties
  private let placeholderText = NSLocalizedString("Enter_text", comment: "텍스트 입력")
  
  private weak var delegate : SourceTextViewControllerDelegate?
  
  private lazy var textView : UITextView = {
    let textView = UITextView()
    textView.text = placeholderText
    textView.textColor = .secondaryLabel
    textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
    textView.returnKeyType = .done
    textView.delegate = self
    return textView
  }()
  
  //MARK: - init
  init(delegate : SourceTextViewControllerDelegate?) {
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .systemBackground
    
    view.addSubview(textView)
    
    textView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(16.0)
    }
  }
  
  //MARK: - @objc func
  
}

  //MARK: - extension UITextViewDelegate
extension SourceTextViewController : UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) { // 글 작성이 시작되었다고 알려주는 메소드 (placeholder 기능을 구현)
    guard textView.textColor == .secondaryLabel else { return }
    
    textView.text = nil
    textView.textColor = .label
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard text == "\n" else { return true } // 완료를 눌렀을때 키값 "\n"
    
    delegate?.didEnterText(textView.text)
    dismiss(animated: true, completion: nil)
    return true
  }
}
