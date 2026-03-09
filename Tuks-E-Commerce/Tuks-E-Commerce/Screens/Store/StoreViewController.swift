import UIKit
import SnapKit

final class StoreViewController: UIViewController {
    
    //MARK: - Properties
    
    private let emptyStateView = EmptyStateView.searchNotFound()
    
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
    
    private let viewModel: StoreViewModel
    private let wishlistViewModel: WishListViewModel
    
    // MARK: - Init

    init(viewModel: StoreViewModel, wishlistViewModel: WishListViewModel) {
        self.viewModel = viewModel
        self.wishlistViewModel = wishlistViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        searchView.isEditable = true
        
        setupUI()
        setupConstraints()
        bindViewModel()
        
        viewModel.search(keyword: searchView.textField.text ?? "")
        
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Setup
        
    private func setupUI() {
        [
            searchView,
            collectionView,
            emptyStateView
        ].forEach { view.addSubview($0) }
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
        
        emptyStateView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadStore),
            name: .wishlistUpdated,
            object: nil
        )
    }
    
    @objc private func reloadStore(_ notification: Notification) {
        guard let productId = notification.userInfo?["productId"] as? Int,
              let index = viewModel.productAll.firstIndex(where: { $0.id == productId }) else { return }
        
        viewModel.productAll[index].isWishlist.toggle()
        collectionView.reloadData()
    }
    
    private func bindViewModel() {
        viewModel.fetchProductSuccess = { [weak self] in
            guard let self else { return }
            collectionView.reloadData()
            emptyStateView.isHidden = !viewModel.productAll.isEmpty
            collectionView.isHidden = viewModel.productAll.isEmpty
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            self?.showError(message: "Error happened while loading search products")
        }
        
        searchView.onTextChanged = { [weak self] keyword in
            self?.viewModel.refreshWishlist(keyword: keyword)
        }
    }
    
    private func showError(message: String) {
        present(AlertHelper.showAlert(title: "Error", message: message), animated: true)
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
        
        let product = viewModel.productAll[indexPath.item]
        cell.configure(with: product)
        
        cell.onFavoriteTapped = { [weak self] in
            self?.wishlistViewModel.addWishlist(id: product.id)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension StoreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.productAll[indexPath.item]
        let detailVC = ProductDetailBuilder.build(productId: product.id)
            navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel.pagination(index: indexPath.row, keyword: searchView.textField.text ?? "")
    }
}
