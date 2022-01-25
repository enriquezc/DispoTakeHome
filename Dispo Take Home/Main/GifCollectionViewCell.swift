//
//  GifCollectionViewCell.swift
//  Dispo Take Home
//
//  Created by Charlie Enriquez-Sarano on 1/24/22.
//

import Foundation
import UIKit

class GifCollectionViewCell: UICollectionViewCell {
  var nameLabel = UILabel()
  var gifImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initializeSubViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initializeSubViews() {
    self.addSubview(nameLabel)
    self.addSubview(gifImageView)
    gifImageView.snp.makeConstraints {
      make in
      make.width.equalToSuperview().multipliedBy(0.3)
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.equalToSuperview().inset(8)
    }
    nameLabel.snp.makeConstraints {
      make in
      make.width.equalToSuperview().inset(16).multipliedBy(0.7).offset(-16)
      make.top.bottom.equalToSuperview()
      make.trailing.equalToSuperview()
    }
    nameLabel.numberOfLines = 0
  }
}

