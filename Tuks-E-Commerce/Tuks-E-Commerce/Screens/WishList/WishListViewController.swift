import UIKit
import SnapKit

final class WishListViewController: UIViewController {
    
    //MARK: - Property
    
    private let emptyStateView = EmptyStateView.wishlist()

    // MARK: - UI Elements
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wishlist"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        return label
    }()
    
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
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bag_logo"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let viewModel: WishListViewModel
    
    // MARK: - Init
    
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        setupConstraints()
        bindViewModel()
        cartButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        viewModel.refreshWishlist()
    }
    
    // MARK: - Setup
        
    private func setupUI() {
        [
            titleLabel,
            cartButton,
            collectionView,
            emptyStateView
        ].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        cartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func cartTapped() {
        let cartVC = BasketBuilder.build()
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.fetchProductSuccess = { [weak self] in
            guard let self else { return }

            self.collectionView.reloadData()
            emptyStateView.isHidden = !viewModel.productAll.isEmpty
            collectionView.isHidden = viewModel.productAll.isEmpty
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            self?.showError(message: "Error happened while loading wishlist products")
        }
    }
    
    private func showError(message: String) {
        present(AlertHelper.showAlert(title: "Error", message: message), animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension WishListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.productAll.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let product = viewModel.productAll[indexPath.item]
        cell.configure(with: product)
        cell.onFavoriteTapped = { [weak self] in
            self?.viewModel.addWishlist(id: product.id)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WishListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.productAll[indexPath.item]
        let detailVC = ProductDetailBuilder.build(productId: product.id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.row)
    }
}
