//
//  MainCollectionViewModel.swift
//  Dispo Take Home
//
//  Created by Charlie Enriquez-Sarano on 1/24/22.
//

import Foundation
import UIKit
import Kingfisher

class MainCollectionViewModel: NSObject {
  private var trendingGifs = [GifObject]()
  private var searchedGifs = [SearchResult]()
  private var currentSearchTerm = ""
  private var loadingGifs = false
  
  var delegate: MainCollectionViewModelDelegate?
  
  
  func getTrendingGifs() {
    if !loadingGifs {
      loadingGifs = true
      GIFNetworkLayer.shared.getTrendingGifs(limit: 50, offset: trendingGifs.count) { [weak self]
        gifObjects in
        self?.trendingGifs.append(contentsOf: gifObjects)
        self?.delegate?.reloadData()
        self?.loadingGifs = false
      }
    }
  }
  
  func searchForGif(offset: Int) {
    if !loadingGifs {
      loadingGifs = true
      GIFNetworkLayer.shared.searchGifByTerm(term: currentSearchTerm, limit: 50, offset: offset) {
        [weak self] searchResults in
        if offset == 0 {
          self?.searchedGifs = searchResults
        } else {
          self?.searchedGifs.append(contentsOf: searchResults)
        }
        self?.delegate?.reloadData()
        self?.loadingGifs = false
      }
    }
  }
  
  func startSearch(term: String) {
    currentSearchTerm = term
    self.searchForGif(offset: 0)
  }
  
  func addMoreGifs() {
    // in this function, we use pagination to add more gifs
    if currentSearchTerm != "" {
      self.searchForGif(offset: searchedGifs.count)
    } else {
      self.getTrendingGifs()
    }
  }
  
  func cancelSearch() {
    currentSearchTerm = ""
    self.delegate?.reloadData()
  }
}

extension MainCollectionViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if currentSearchTerm != "" {
      return searchedGifs.count
    }
    return trendingGifs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as! GifCollectionViewCell
    
    if currentSearchTerm != "" {
      cell.nameLabel.text = searchedGifs[indexPath.row].title
      cell.gifImageView.kf.setImage(with: searchedGifs[indexPath.row].gifUrl)
    } else {
      cell.nameLabel.text = trendingGifs[indexPath.row].title
      cell.gifImageView.kf.setImage(with: trendingGifs[indexPath.row].images.fixed_height.url)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var id = ""
    if currentSearchTerm != "" {
      id = searchedGifs[indexPath.row].id
      
    } else {
      id = trendingGifs[indexPath.row].id
    }
    self.delegate?.loadDetailViewWithId(id: id)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    // this is the code that introduces pagination when the user
    // scrolls down to see the last ten items
    var numberOfItems = 0
    if currentSearchTerm != "" {
      numberOfItems = searchedGifs.count
    } else {
      numberOfItems = trendingGifs.count
    }
    
    if (numberOfItems - indexPath.row <= 10) {
      self.addMoreGifs()
    }
  }
  
}

protocol MainCollectionViewModelDelegate {
  func reloadData()
  func loadDetailViewWithId(id: String)
}
