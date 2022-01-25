import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  var gifImageView = UIImageView()
  var gifTitleLabel = UILabel()
  var idLabel = UILabel()
  var sourceLabel = UILabel()
  var ratingLabel = UILabel()
  
  var viewModel: DetailViewModel?
  
  init(id: String) {
    super.init(nibName: nil, bundle: nil)
    viewModel = DetailViewModel(id: id)
    viewModel?.getGifInfo()
    viewModel?.delegate = self
  }

  override func loadView() {
    view = UIView()
    let title = UILabel()
    view.addSubview(title)
    view.addSubview(gifImageView)
    view.addSubview(gifTitleLabel)
    view.addSubview(idLabel)
    view.addSubview(sourceLabel)
    view.addSubview(ratingLabel)
    view.backgroundColor = .systemBackground
    
    title.text = "Gif Details"
    title.textAlignment = .center
    
    gifTitleLabel.numberOfLines = 0
    
    title.snp.makeConstraints{
      make in
      make.width.equalToSuperview().multipliedBy(0.5)
      make.top.equalToSuperview().inset(16)
      make.centerX.equalToSuperview()
    }
    
    gifImageView.snp.makeConstraints {
      make in
      make.width.equalToSuperview().inset(16)
      make.top.equalTo(title.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalToSuperview().multipliedBy(0.4)
    }
    
    gifTitleLabel.snp.makeConstraints {
      make in
      make.width.equalToSuperview().inset(16)
      make.top.equalTo(gifImageView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    idLabel.snp.makeConstraints {
      make in
      make.width.equalToSuperview().inset(16)
      make.top.equalTo(gifTitleLabel.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    sourceLabel.snp.makeConstraints {
      make in
      make.width.equalToSuperview().inset(16)
      make.top.equalTo(idLabel.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    ratingLabel.snp.makeConstraints{
      make in
      make.width.equalToSuperview().inset(16)
      make.top.equalTo(sourceLabel.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DetailViewController: DetailViewModelDelegate {
  func loadGifInfo(gifInfo: GifInfo) {
    gifImageView.kf.setImage(with: gifInfo.gifUrl)
    gifTitleLabel.text = gifInfo.text
    sourceLabel.text = "Source: " + gifInfo.source_tld
    ratingLabel.text = "Rating: " + gifInfo.rating
    idLabel.text = "Id: " + gifInfo.id
  }
}
