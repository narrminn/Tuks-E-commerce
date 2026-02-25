import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - UI Elements

    private let searchView = CustomSearchView()

    private lazy var collectionView: UICollectionView = {
        let layout = HomeLayoutFactory.createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray6

        cv.showsVerticalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        registerCells(cv)
        return cv
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_mock")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let greetingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good day for shopping,"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Narmin Alasova"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bag_logo"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let viewModel: HomeViewModel
    let wishlistViewModel: WishListViewModel
    
    init(viewModel: HomeViewModel, wishlistViewModel: WishListViewModel) {
        self.viewModel = viewModel
        self.wishlistViewModel = wishlistViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        addSubviews()
        setupConstraints()
        bindActions()
        bindViewModel()
        
        nameLabel.text = (UserDefaults.standard.string(forKey: UserDefaultsKeys.name) ?? "") +
        " " + (
            UserDefaults.standard.string(forKey: UserDefaultsKeys.surname) ?? ""
        )
        
        if let profileImage = UserDefaults.standard.string(
            forKey: UserDefaultsKeys.profilePhotoPath
        ) {
            profileImageView.loadImage(url: profileImage)
        }
        
        viewModel.getCompanyList()
        viewModel.getPopularProduct()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadHome),
            name: .wishlistUpdated,
            object: nil
        )
        
        
    }

    @objc private func reloadHome(_ notification: Notification) {
        guard let productId = notification.userInfo?["productId"] as? Int else { return }
        
        if let index = viewModel.productAll.firstIndex(where: { $0.id == productId }) {
            viewModel.productAll[index].isWishlist.toggle()
            let indexPath = IndexPath(item: index, section: HomeSection.products.rawValue)
            collectionView.reloadItems(at: [indexPath])
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Setup
    private func addSubviews() {
        
        greetingStackView.addArrangedSubview(greetingLabel)
        greetingStackView.addArrangedSubview(nameLabel)
        
        view.addSubview(profileImageView)
        view.addSubview(greetingStackView)
        view.addSubview(cartButton)
        view.addSubview(searchView)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.size.equalTo(44)
        }

        greetingStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.centerY.equalTo(profileImageView)
        }

        cartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(profileImageView)
            make.width.height.equalTo(24)
        }

        searchView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func registerCells(_ cv: UICollectionView) {
        cv.register(
            BrandCollectionViewCell.self,
            forCellWithReuseIdentifier: BrandCollectionViewCell.identifier
        )
        cv.register(
            BannerCollectionViewCell.self,
            forCellWithReuseIdentifier: BannerCollectionViewCell.identifier
        )
        cv.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
        cv.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
    }

    // MARK: - Bind

    private func bindActions() {
        searchView.onSearchTapped = { [weak self] in
            self?.switchToSearchTab()
        }
        
        cartButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
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
                    message: "Error happened while load products"
                ),
                animated: true
            )
        }
        
        wishlistViewModel.errorHandling = { [weak self] errorText in
            guard let self else { return }
            
            self.present(
                AlertHelper.showAlert(
                    title: "Error",
                    message: "Error happened while wishlist products"
                ),
                animated: true
            )
        }
        
        viewModel.fetchCompanyListSuccess = { [weak self ] in
            guard let self else { return }
            
            self.collectionView.reloadData()
        }
    }

    // MARK: - Actions

    @objc private func cartTapped() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }

    private func switchToSearchTab() {
        tabBarController?.selectedIndex = 1
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let sectionType = HomeSection(rawValue: section) else { return 0 }
        switch sectionType {
        case .brands:   return viewModel.companyListResponse?.data?.companies?.count ?? 0
        case .banner:   return MockData.bannerImages.count
        case .products: return viewModel.productAll.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let sectionType = HomeSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }

        switch sectionType {
        case .brands:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BrandCollectionViewCell.identifier,
                for: indexPath
            ) as? BrandCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let company = viewModel.companyListResponse?.data?.companies?[indexPath.row] else {
                return cell
            }
            
            cell.configure(with: company)
            return cell

        case .banner:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.identifier,
                for: indexPath
            ) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(imageName: MockData.bannerImages[indexPath.item])
            return cell

        case .products:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCollectionViewCell.identifier,
                for: indexPath
            ) as? ProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModel.productAll[indexPath.row])
            
            cell.onFavoriteTapped = {[weak self] in
                guard let self else { return }
                
                wishlistViewModel.addWishlist(id: viewModel.productAll[indexPath.row].id)
                
            }
            
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let sectionType = HomeSection(rawValue: indexPath.section),
              let title = sectionType.title,
              let header = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: SectionHeaderView.identifier,
                  for: indexPath
              ) as? SectionHeaderView
        else {
            return UICollectionReusableView()
        }

        header.configure(title: title)
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let sectionType = HomeSection(rawValue: indexPath.section) else { return }

        switch sectionType {
        case .brands:
            print("Selected brand at index: \(indexPath.item)")

        case .products:
            // TODO: - ProductDetailViewController-a push et
            print("Selected product at index: \(indexPath.item)")

        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let sectionType = HomeSection(rawValue: indexPath.section) else { return }
        
        switch sectionType {
        case .products:
            viewModel.pagination(index: indexPath.row)
        default:
            break
        }
    }
}
