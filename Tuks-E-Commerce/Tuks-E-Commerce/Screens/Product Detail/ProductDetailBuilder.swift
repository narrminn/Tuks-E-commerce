final class ProductDetailBuilder {
    static func build(productId: Int) -> ProductDetailViewController {
        let networkService = DefaultNetworkService()
        let viewModel = ProductDetailViewModel(networkService: networkService, id: productId)
        let wishlistViewModel = WishListViewModel(networkService: networkService)
        let basketViewModel = BasketViewModel(networkService: networkService)
        return ProductDetailViewController(
            viewModel: viewModel,
            wishlistViewModel: wishlistViewModel,
            basketViewModel: basketViewModel
        )
    }
}
