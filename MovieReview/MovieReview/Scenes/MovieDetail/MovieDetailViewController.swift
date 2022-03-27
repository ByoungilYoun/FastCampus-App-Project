//
//  MovieDetailViewController.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/21.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieDetailViewController : UIViewController {
  
  //MARK: - Properties
  private var presenter : MovieDetailPresenter!
  
  private lazy var imageView : UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .secondarySystemBackground
    return imageView
  }()
  
  private lazy var rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
  
  
  //MARK: - Init
  init(movie : Movie) {
    super.init(nibName: nil, bundle: nil)
    self.presenter = MovieDetailPresenter(viewController: self, movie: movie)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
  
  //MARK: - Functions
  func setRightBarButton(with isLiked : Bool) {
    let imageName = isLiked ? "star.fill" : "star"
    rightBarButtonItem.image = UIImage(systemName: imageName)
  }
  
  //MARK: - @objc func
  @objc func didTapRightBarButtonItem() {
    presenter.didTapRightBarButtonItem()
  }
}

  //MARK: - MovieDetailProtocol
extension MovieDetailViewController : MovieDetailProtocol {
  func setupViews(with movie : Movie) {
    view.backgroundColor = .systemBackground
    navigationItem.title = movie.title
    navigationItem.rightBarButtonItem = rightBarButtonItem
    
    let userRatingContentsStackView = MovieContentsStackView(title: "평점", contents: movie.userRating)
    let actorContentsStackView = MovieContentsStackView(title: "배우", contents: movie.actor)
    let directorContentsStackView = MovieContentsStackView(title: "감독", contents: movie.director)
    let pubDateContentsStackView = MovieContentsStackView(title: "제작년도", contents: movie.pubDate)
    
    let contentStackView = UIStackView()
    contentStackView.axis = .vertical
    contentStackView.spacing = 8.0
    
    [userRatingContentsStackView, actorContentsStackView, directorContentsStackView, pubDateContentsStackView].forEach {
      contentStackView.addArrangedSubview($0)
    }
    
    [imageView, contentStackView].forEach {
      view.addSubview($0)
    }
    
    let inset : CGFloat = 16.0
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
      $0.leading.equalToSuperview().inset(inset)
      $0.trailing.equalToSuperview().inset(inset)
      $0.height.equalTo(imageView.snp.width)
    }
    
    if let imageUrl = movie.imageURL {
      imageView.kf.setImage(with: imageUrl)
    }
    
    contentStackView.snp.makeConstraints {
      $0.leading.trailing.equalTo(imageView)
      $0.top.equalTo(imageView.snp.bottom).offset(inset)
    }
    
  }
}
