import UIKit

struct SearchResult {
  var id: String
  var gifUrl: URL
  var title: String
  
  init(gifObject: GifObject) {
    id = gifObject.id
    title = gifObject.title
    gifUrl = gifObject.images.fixed_height.url
  }
}
