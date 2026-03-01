import UIKit
import SnapKit

final class ProductDetailViewController: UIViewController {

    // MARK: - Properties
    private var selectedVariantIndex: Int = 0
    private var selectedImageIndex: Int = 0
    
    private var thumbnailUrls: [String] = []
    
    private var options: [Option] = []
    private var selectedValues: [Int: Int] = [:]
    
    private var isWishList = false

    // MARK: - UI
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()

    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var favoriteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: Icon.heart.title), for: .normal)
        btn.tintColor = .gray
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        return btn
    }()

    private lazy var mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor(white: 0.96, alpha: 1)
        iv.clipsToBounds = true
        return iv
    }()

    private lazy var thumbnailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: 72)
        layout.minimumInteritemSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.reuseID)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    private lazy var infoCard: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return v
    }()

    private lazy var ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "⭐️ 5.0 (199)"
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .darkGray
        return lbl
    }()

    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        btn.tintColor = .darkGray
        return btn
    }()

    private lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$49.40"
        lbl.font = .boldSystemFont(ofSize: 26)
        lbl.textColor = .black
        return lbl
    }()

    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Nike Offcourt"
        lbl.font = .systemFont(ofSize: 17)
        lbl.textColor = .black
        return lbl
    }()

    private lazy var brandLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "NIKE"
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.textColor = .black
        return lbl
    }()

    private lazy var brandIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark.seal.fill")
        iv.tintColor = .systemBlue
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private lazy var optionsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()

    private lazy var descriptionTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Descriptions"
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textColor = .black
        return lbl
    }()

    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 3
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .darkGray
        lbl.text = ""
        return lbl
    }()

    private lazy var addToBagButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add to bag", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = UIColor(red: 0.27, green: 0.38, blue: 0.9, alpha: 1)
        btn.layer.cornerRadius = 14
        btn.addTarget(self, action: #selector(addToBagTapped), for: .touchUpInside)
        return btn
    }()
    
    let viewModel: ProductDetailViewModel
    let wishlistViewModel: WishListViewModel
    let basketViewModel: BasketViewModel

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupUI()
        bindViewModel()
        viewModel.getProductDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBar()
    }
    
    init(
        viewModel: ProductDetailViewModel,
        wishlistViewModel: WishListViewModel,
        basketViewModel: BasketViewModel
    ) {
        self.viewModel = viewModel
        self.wishlistViewModel = wishlistViewModel
        self.basketViewModel = basketViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        viewModel.productDetailSuccess = { [weak self] in
            guard let self, let product = viewModel.productResponse?.data?.product else { return }
            configure(with: product)
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
    }
    
    // MARK: - Configure
    private func configure(with product: ProductDetail) {
        nameLabel.text = product.name
        priceLabel.text = "$\(product.price ?? 0)"
        ratingLabel.text = "⭐️ \(product.rating ?? 0)"
        brandLabel.text = product.company?.name
        descriptionLabel.text = product.description
        isWishList = product.isWishlist ?? false
        setWishListImage()

        if let logo = product.company?.logo {
            brandIcon.loadImage(fullURL: logo)
        }

        thumbnailUrls = product.images?.compactMap { $0.url } ?? []
        if let mainUrl = product.images?.first(where: { $0.isMain == true })?.url {
            mainImageView.loadImage(fullURL: mainUrl)
        }
        thumbnailCollectionView.reloadData()

        options = product.options ?? []
        buildOptionSections()
    }
    
    // MARK: - Wishlist
    private func setWishListImage() {
        let heartName = isWishList ? Icon.heartFilled.title : Icon.heart.title
        let heartColor: UIColor = isWishList ? .systemRed : .gray
        favoriteButton.setImage(UIImage(systemName: heartName), for: .normal)
        favoriteButton.tintColor = heartColor
    }
    
    // MARK: - Build Options
    private func buildOptionSections() {
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        selectedValues = [:]

        for (index, option) in options.enumerated() {
            selectedValues[index] = 0

            let titleLabel = UILabel()
            titleLabel.text = option.name
            titleLabel.font = .boldSystemFont(ofSize: 17)
            titleLabel.textColor = .black

            let cv = makeVariantCollectionView(tag: index)

            let section = UIStackView(arrangedSubviews: [titleLabel, cv])
            section.axis = .vertical
            section.spacing = 8
            cv.snp.makeConstraints { $0.height.equalTo(36) }

            optionsStackView.addArrangedSubview(section)
        }
    }
    
    private func makeVariantCollectionView(tag: Int) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.tag = tag
        cv.register(VariantCell.self, forCellWithReuseIdentifier: VariantCell.reuseID)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }

    // MARK: - Setup
    private func setupUI() {
        view.addSubview(mainImageView)
        view.addSubview(thumbnailCollectionView)
        view.addSubview(backButton)
        view.addSubview(favoriteButton)
        view.addSubview(scrollView)
        view.addSubview(addToBagButton)
        scrollView.addSubview(contentView)

        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }

        thumbnailCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(mainImageView.snp.bottom).offset(-16)
            $0.height.equalTo(72)
        }

        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        favoriteButton.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        addToBagButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(addToBagButton.snp.top).offset(-8)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        contentView.addSubview(infoCard)

        infoCard.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }

        let brandRow = UIStackView(arrangedSubviews: [brandIcon, brandLabel])
        brandRow.spacing = 6
        brandRow.alignment = .center
        brandIcon.snp.makeConstraints { $0.size.equalTo(16) }

        [ratingLabel, shareButton, priceLabel, nameLabel,
         brandRow, optionsStackView, descriptionTitleLabel, descriptionLabel].forEach { infoCard.addSubview($0) }

        ratingLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        shareButton.snp.makeConstraints {
            $0.centerY.equalTo(ratingLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        brandRow.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        optionsStackView.snp.makeConstraints {
            $0.top.equalTo(brandRow.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(optionsStackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)

        }
    }

    // MARK: - Actions
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func favoriteTapped() {
        isWishList = !isWishList
        setWishListImage()
        wishlistViewModel.addWishlist(id: viewModel.id)
    }

    @objc private func addToBagTapped() {
        let selectedAttributeIds: [Int] = selectedValues.compactMap { (optionIndex, valueIndex) in
            options[optionIndex].values?[valueIndex].id
        }
        
        guard let variant = viewModel.productResponse?.data?.product?.variants?.first(where: { variant in
            guard let attributes = variant.attributes else { return false }
            return selectedAttributeIds.allSatisfy { attributes.contains($0) }
        }) else {
            present(
                AlertHelper.showAlert(title: "Error", message: "Please select a valid variant"),
                animated: true
            )
            return
        }
        
        basketViewModel.addToBasket(
            body: AddToBasketRequest(variantID: variant.id, quantity: 1)
        )
    }
}

// MARK: - UICollectionView
extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == thumbnailCollectionView {
            return thumbnailUrls.count
        }
        return options[collectionView.tag].values?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == thumbnailCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.reuseID, for: indexPath) as! ThumbnailCell
            
            cell.configure(
                imageUrl: thumbnailUrls[indexPath.item],
                isSelected: indexPath.item == selectedImageIndex,
                isLast: indexPath.item == thumbnailUrls.count - 1,
                remaining: thumbnailUrls.count - 3
            )
            return cell
        }
        
        let optionIndex = collectionView.tag
        let value = options[optionIndex].values![indexPath.item]
        let isSelected = selectedValues[optionIndex] == indexPath.item
        let isAvailable = viewModel.productResponse?.data?.product?.variants?
            .first { $0.attributes?.contains(value.id ?? -1) == true }?
            .inStock ?? true

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VariantCell.reuseID, for: indexPath) as! VariantCell
        cell.configure(value: value, isSelected: isSelected, isAvailable: isAvailable)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == thumbnailCollectionView {
            return CGSize(width: 72, height: 72)
        }
        let text = options[collectionView.tag].values?[indexPath.item].value ?? ""
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 40
        return CGSize(width: max(width, 56), height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == thumbnailCollectionView {
            selectedImageIndex = indexPath.item
            thumbnailCollectionView.reloadData()
            mainImageView.loadImage(fullURL: thumbnailUrls[indexPath.item])
        } else {
            selectedValues[collectionView.tag] = indexPath.item
            collectionView.reloadData()
        }
    }
}
