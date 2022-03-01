//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by 윤병일 on 2022/02/28.
//

import UIKit
import SnapKit

final class ReviewWriteViewController : UIViewController {
  
  //MARK: - Properties
  private lazy var presenter = ReviewWritePresenter(viewController: self)
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}


  //MARK: - ReviewWriteProtocol
extension ReviewWriteViewController : ReviewWriteProtocol {
  func setupNavigationBar() {
    view.backgroundColor = .white
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapLeftBarButton))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
  }
  
  func showCloseAlertController() {
    let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?", message: nil, preferredStyle: .alert)
    let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
      self?.dismiss(animated: true, completion: nil)
    }
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)

    [closeAction, cancelAction].forEach {
      alertController.addAction($0)
    }
    self.present(alertController, animated: true)
  }
}

  //MARK: - Extension ReviewWriteViewController
private extension ReviewWriteViewController {
  @objc func didTapLeftBarButton() {
    presenter.didTapLeftBarButton()
  }
}
