import UIKit
import Alamofire

class GIFNetworkLayer {
    
  static let shared = GIFNetworkLayer()
  
  private init() {
    // this singleton doesn't require anything in its initialization
    print("Initializing GIFNetworkLayer")
  }
    
  func getGifById(id: String, completion: @escaping (_ gif: GifInfo) -> Void) {
    let path = Constants.gifBaseURL + id
    let params = ["api_key": Constants.giphyApiKey] as [String: Any]
    
    AF.request(path, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
      switch response.result {
        case .success:
          do {
            let decoder = JSONDecoder()
            let gifByIdGifObject = try decoder.decode( APISingleResponse.self, from: response.data!)
            let gifByIdInfo = GifInfo.init(gifObject: gifByIdGifObject.data)
            completion(gifByIdInfo)
          } catch (let error) {
            print("we failed to decode the results ", error.localizedDescription)
            print(error)
          }
        case .failure(let error):
          print("we got this error: ", error.localizedDescription)
      }
    }
  }
  
  func getTrendingGifs(limit: Int, offset: Int, completion: @escaping (_ gifs: [GifObject]) -> Void) {
    let path = Constants.gifBaseURL + "trending"
    
    let params = ["api_key": Constants.giphyApiKey, "limit": limit, "offset": offset, "rating": "pg"] as [String: Any]
    
    AF.request(path, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
      switch response.result {
        case .success:
          do {
            let decoder = JSONDecoder()
            let trendingGifs = try decoder.decode(APIListResponse.self, from: response.data!)
            completion(trendingGifs.data)
          } catch (let error) {
            print("we failed to decode the results ", error.localizedDescription)
          }
        case .failure(let error):
          print("we got this error: ", error.localizedDescription)
      }
    }
  }
  
  func searchGifByTerm(term: String, limit: Int, offset: Int, completion: @escaping (_ results: [SearchResult]) -> Void) {
    let path = Constants.gifBaseURL + "search"
    
    let params = ["api_key": Constants.giphyApiKey, "q": term, "limit": limit, "offset": offset, "rating": "pg"] as [String: Any]
    
    AF.request(path, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
      switch response.result {
        case .success:
          do {
            let decoder = JSONDecoder()
            let searchResultGifObjects = try decoder.decode(APIListResponse.self, from: response.data!).data
            let searchResults = searchResultGifObjects.map {
              (gifObject) -> SearchResult in
              return SearchResult(gifObject: gifObject)
            }
            completion(searchResults)
          } catch (let error) {
            print("we failed to decode the results ", error.localizedDescription)
          }
        case .failure(let error):
          print("we got this error: ", error.localizedDescription)
      }
    }
  }
}
