import UIKit

class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.titleView = searchBar

  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "search gifs..."
    searchBar.delegate = self
    return searchBar
  }()

  private var layout: UICollectionViewLayout {
    // TODO: implement
    let screenWidth = UIScreen.main.bounds.width
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
    return layout
  }

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.backgroundColor = .clear
    collectionView.keyboardDismissMode = .onDrag
    return collectionView
  }()
}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // TODO: implement
  }
}
