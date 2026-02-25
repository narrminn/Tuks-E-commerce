import UIKit
import SnapKit

final class WishListViewController: UIViewController {

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
    
    let viewModel: WishListViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addSubviews()
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
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(cartButton)
        view.addSubview(collectionView)
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
    }
    
    @objc private func cartTapped() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
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
                    message: "Error happened while load wishlist products"
                ),
                animated: true
            )
            
        }
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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.productAll[indexPath.item])
        
        cell.onFavoriteTapped = { [weak self] in
            guard let self else { return }
            viewModel.addWishlist(id: viewModel.productAll[indexPath.item].id)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WishListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        // TODO: ProductDetailViewController-a push et
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel.pagination(index: indexPath.row)
    }
}
