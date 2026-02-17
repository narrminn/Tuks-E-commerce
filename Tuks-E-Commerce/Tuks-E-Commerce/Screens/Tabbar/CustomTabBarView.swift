import UIKit
import SnapKit

final class CustomTabBarView: UIView {

    var onSelect: ((Int) -> Void)?

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    private var items: [TabBarItemView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .systemBackground
        setupBorder()
        setupConstraints()
        setupItems()
    }

    private func setupBorder() {
        let border = UIView()
        border.backgroundColor = .systemGray4
        addSubview(border)
        border.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    private func setupConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(36)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(56)
        }
    }

    private func setupItems() {
        let home = TabBarItemView(title: "Home", icon: "house", filledIcon: "house.fill")
        let store = TabBarItemView(title: "Store", icon: "storefront", filledIcon: "storefront.fill")
        let wishlist = TabBarItemView(title: "Wishlist", icon: "heart", filledIcon: "heart.fill")
        let profile = TabBarItemView(title: "Profile", icon: "person", filledIcon: "person.fill")

        items = [home, store, wishlist, profile]

        items.enumerated().forEach { index, item in
            item.onTap = { [weak self] in
                self?.select(index: index)
            }
            stackView.addArrangedSubview(item)
        }
    }

    private func select(index: Int) {
        setSelected(index: index)
        onSelect?(index)
    }

    func setSelected(index: Int) {
        items.enumerated().forEach { i, item in
            item.setSelected(i == index)
        }
    }
}
