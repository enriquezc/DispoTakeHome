//
//  DetailViewModel.swift
//  Dispo Take Home
//
//  Created by Charlie Enriquez-Sarano on 1/25/22.
//

import Foundation

class DetailViewModel: NSObject {
  
  var id: String
  var delegate: DetailViewModelDelegate?
  
  init(id: String) {
    self.id = id
    super.init()
  }
  
  func getGifInfo() {
    GIFNetworkLayer.shared.getGifById(id: self.id) {
      gifInfo in
      // here we return the gif info to the detail view controller
      self.delegate?.loadGifInfo(gifInfo: gifInfo)
    }
  }
}

protocol DetailViewModelDelegate {
  func loadGifInfo(gifInfo: GifInfo)
}

