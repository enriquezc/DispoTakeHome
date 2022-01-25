import UIKit

class MainViewController: UIViewController {
  
  var viewModel: MainCollectionViewModel?
  

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
    
    collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: "gifCell")
    
    viewModel = MainCollectionViewModel()
    viewModel?.delegate = self
    collectionView.delegate = viewModel
    collectionView.dataSource = viewModel
    
    viewModel?.getTrendingGifs()
    
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
    layout.itemSize = CGSize(width: screenWidth, height: screenWidth / 3)
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
    if searchText != "" {
      self.viewModel?.startSearch(term: searchText)
    }
  }
}

extension MainViewController: MainCollectionViewModelDelegate {
  func reloadData() {
    self.collectionView.reloadData()
    print("we tried to reload some data after getting the data")
  }
  
  func loadDetailViewWithId(id: String) {
    // here we load the detail view
  }
}
