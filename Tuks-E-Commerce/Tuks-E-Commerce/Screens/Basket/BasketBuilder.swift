final class BasketBuilder {
    static func build() -> BasketViewController {
        let networkService = DefaultNetworkService()
        let viewModel = BasketViewModel(networkService: networkService)
        return BasketViewController(viewModel: viewModel)
    }
}
