import UIKit

struct GifInfo {
  var id: String
  var gifUrl: URL
  var text: String
  var backgroundColor: UIColor?
  var source_tld: String
  var rating: String
  
  init(gifObject: GifObject) {
    id = gifObject.id
    text = gifObject.title
    gifUrl = gifObject.images.fixed_height.url
    source_tld = gifObject.source_tld
    rating = gifObject.rating
  }
}
