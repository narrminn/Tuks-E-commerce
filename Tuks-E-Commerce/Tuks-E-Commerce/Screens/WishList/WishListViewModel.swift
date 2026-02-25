import Foundation

final class WishListViewModel {
    let networkService: NetworkService
    
    var productResponse: ProductListResponse?
    var productAll: [Product] = []
    
    var fetchProductSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?

    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func addWishlist(id: Int) {
        Task {
            do {
                let _ : SuccessResponse = try await networkService.request(
                    ProductEndPoint.addWishlist(id: id))
                
                await MainActor.run {
                    NotificationCenter.default.post(name: .wishlistUpdated, object: nil,
                                                    userInfo: ["productId": id])
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    errorHandling?(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getWishlist() {
        Task {
            do {
                let productResponse: ProductListResponse = try await networkService.request(
                    ProductEndPoint
                        .getWishlist(
                            page: (productResponse?.meta?.page ?? 0) + 1
                        )
                )
                
                self.productResponse = productResponse
                productAll.append(contentsOf: productResponse.data?.products ?? [])
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    fetchProductSuccess?()
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    errorHandling?(error.localizedDescription)
                }
            }
            
        }
    }
    
    func pagination(index: Int) {
        let productCount = productAll.count
        let meta = productResponse?.meta
        
        if productCount - 2 == index &&
            (meta?.page ?? 0 < meta?.totalPage ?? 0)
        {
            getWishlist()
        }
    }
    
    func refreshWishlist() {
        productResponse = nil
        productAll = []
        getWishlist()
    }
}
