import UIKit
import SnapKit

final class StoreViewController: UIViewController {
    
    // MARK: - UI Elements

    private let searchView = CustomSearchView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 50, right: 20)
        let itemWidth = (view.bounds.width - 52) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 280)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(ProductCollectionViewCell.self,
                     forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        return cv
    }()
    
    let viewModel: StoreViewModel
    let wishlistViewModel: WishListViewModel
    
    init(viewModel: StoreViewModel, wishlistViewModel: WishListViewModel) {
        self.viewModel = viewModel
        self.wishlistViewModel = wishlistViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        searchView.isEditable = true
        
        addSubviews()
        setupConstraints()
        bindViewModel()
        
        viewModel.search(keyword: searchView.textField.text ?? "")
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadStore),
            name: .wishlistUpdated,
            object: nil
        )
    }
    
    @objc private func reloadStore(_ notification: Notification) {
        guard let productId = notification.userInfo?["productId"] as? Int else { return }
        
        if let index = viewModel.productAll.firstIndex(where: { $0.id == productId }) {
            viewModel.productAll[index].isWishlist.toggle()
            collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.fetchProductSuccess = { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            guard let self else { return }
            
            self.present(
                AlertHelper.showAlert(
                    title: "Error",
                    message: "Error happened while load search products"
                ),
                animated: true
            )
        }
        
        searchView.onTextChanged = { [weak self] keyword in
            guard let self else { return }
            viewModel.refreshWishlist(keyword: keyword)
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension StoreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.productAll.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.productAll[indexPath.item])
        
        cell.onFavoriteTapped = { [weak self] in
            guard let self else { return }
            wishlistViewModel.addWishlist(id: viewModel.productAll[indexPath.item].id)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension StoreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.productAll[indexPath.item]
            let detailVM = ProductDetailViewModel(
                networkService: DefaultNetworkService(),
                id: product.id
            )
        let detailVC = ProductDetailViewController(
            viewModel: detailVM,
            wishlistViewModel: WishListViewModel(
                networkService: DefaultNetworkService()
            ),
            basketViewModel: BasketViewModel(
                networkService: DefaultNetworkService()
            )
        )
            navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel.pagination(index: indexPath.row, keyword: searchView.textField.text ?? "")
    }
}
