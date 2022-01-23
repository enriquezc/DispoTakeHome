import UIKit
import Alamofire

struct GifAPIClient {
  // TODO: Implement
}

class GIFNetworkLayer {
    
    static let shared = GIFNetworkLayer()
    
    private init() {
        // not sure if we need anything in the initializer - maybe a singleton isn't the best
    }
    
    func getGifById(id: String) {
        
    }
    
    func getTrendingGifs() {
        
    }
    
    func searchGifByTerm(term: String) {
        
    }
}
