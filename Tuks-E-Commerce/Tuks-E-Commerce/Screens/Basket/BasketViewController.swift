import UIKit
import SnapKit

final class BasketViewController: UIViewController {
    
    // MARK: - UI
        
    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return btn
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Bag"
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.register(BagItemCell.self, forCellReuseIdentifier: BagItemCell.identifier)
        return tv
    }()
    
    private let bottomView = UIView()
    private let subtotalRow = SummaryRow(title: "Subtotal")
    private let taxRow = SummaryRow(title: "Tax and fees")
    private let deliveryRow = SummaryRow(title: "Delivery", defaultValue: "Free")
    private let totalRow = SummaryRow(title: "Total", isBold: true)
    
    private lazy var checkoutButton: MainButton = {
        let btn = MainButton(text: "Checkout")
        btn.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        return btn
    }()
    
    private let viewModel: BasketViewModel
        
    // MARK: - Init
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        configureViewModel()
        viewModel.getBasketItems()
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
    
    
    // MARK: - Configure ViewModel
        
    private func configureViewModel() {
        viewModel.getBasketItemsSuccess = { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
            self.updateSummary(subtotal: Double(self.viewModel.totalPrice))
        }
        
        viewModel.errorHandling = { message in
            print(message)
        }
        
        viewModel.deleteBasketItemSuccess = { [weak self] in
            guard let self else { return }
            self.viewModel.getBasketItems()
        }
        
        viewModel.checkoutSuccess = { [weak self] in
            
            let successVC = SuccessViewController.orderPlaced {
                self?.navigationController?.popToRootViewController(animated: true)
            }

            self?.navigationController?.pushViewController(successVC, animated: true)
        }
    }
    
    // MARK: - Setup UI
        
    private func setupUI() {
        [backButton, titleLabel, tableView, bottomView].forEach { view.addSubview($0) }

        
        let divider = makeDivider()
        let summaryStack = UIStackView(arrangedSubviews: [
            subtotalRow, taxRow, deliveryRow, makeDivider(), totalRow
        ])
        summaryStack.axis = .vertical
        summaryStack.spacing = 12
        
        [divider, summaryStack, checkoutButton].forEach { bottomView.addSubview($0) }
        
        divider.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        summaryStack.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.top.equalTo(summaryStack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.leading.equalTo(backButton.snp.trailing).offset(12)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
    
    // MARK: - Update Summary
    
    private func updateSummary(subtotal: Double, tax: Double = 0, delivery: Double = 0) {
        subtotalRow.setValue(String(format: "$%.2f", subtotal))
        taxRow.setValue(String(format: "$%.2f", tax))
        deliveryRow.setValue(delivery == 0 ? "Free" : String(format: "$%.2f", delivery))
        totalRow.setValue(String(format: "$%.2f", subtotal + tax + delivery))
    }
    
    // MARK: - Actions
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func checkoutTapped() {
        viewModel.checkout()
    }
    
    // MARK: - Helpers
    
    private func makeDivider() -> UIView {
        let v = UIView()
        v.backgroundColor = .systemGray4
        v.snp.makeConstraints { $0.height.equalTo(1) }
        return v
    }
}


// MARK: - UITableViewDataSource & Delegate

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagItemCell.identifier, for: indexPath) as! BagItemCell
        let item = viewModel.basketItems[indexPath.row]
        cell.configure(item: item)
        cell.delegate = self
        return cell
    }
}

// MARK: - BagItemCellDelegate

extension BasketViewController: BagItemCellDelegate {
    
    func bagItemCellDidTapMore(basketId: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(.init(title: "Remove from bag", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteBasketItem(basketId: basketId)
        })
        alert.addAction(.init(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
