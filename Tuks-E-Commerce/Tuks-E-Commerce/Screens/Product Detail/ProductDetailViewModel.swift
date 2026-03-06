import Foundation

final class ProductDetailViewModel {
    let networkService: NetworkService
    
    var productResponse: ProductDetailResponse?
    var id: Int
    
    var productDetailSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService, id: Int) {
        self.networkService = networkService
        self.id = id
    }
    
    func getProductDetail() {
        Task {
            do {
                let productDetail: ProductDetailResponse = try await  networkService.request(
                    ProductEndPoint.detail(id: id)
                )
                
                self.productResponse = productDetail
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    productDetailSuccess?()
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    errorHandling?(error.localizedDescription)
                }
            }
        }
    }
}
