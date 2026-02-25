import Foundation

final class StoreViewModel {
    let networkService: NetworkService
    
    var productResponse: ProductListResponse?
    var productAll: [Product] = []
    
    var fetchProductSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func search(keyword: String) {
        Task {
            do {
                let productResponse: ProductListResponse = try await networkService.request(
                    ProductEndPoint.search(page: (productResponse?.meta?.page ?? 0) + 1,
                            keyword: keyword)
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
    
    func pagination(index: Int, keyword: String) {
        let productCount = productAll.count
        let meta = productResponse?.meta
        
        if productCount - 2 == index &&
            (meta?.page ?? 0 < meta?.totalPage ?? 0)
        {
            search(keyword: keyword)
        }
    }
    
    func refreshWishlist(keyword: String) {
        productResponse = nil
        productAll = []
        search(keyword: keyword)
    }
}
