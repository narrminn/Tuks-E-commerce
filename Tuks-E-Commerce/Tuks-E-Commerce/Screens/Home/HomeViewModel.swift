import Foundation

final class HomeViewModel {
    let networkService: NetworkService
    
    var productResponse: ProductListResponse?
    var productAll: [Product] = []
    
    var companyListResponse: CompanyListResponse?
    
    var fetchProductSuccess: (() -> Void)?
    var fetchCompanyListSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getPopularProduct() {
        Task {
            do {
                let productResponse: ProductListResponse = try await networkService.request(
                    ProductEndPoint
                        .getPopularProduct(
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
    
    func getCompanyList() {
        Task {
            do {
                let companyListResponse: CompanyListResponse = try await  networkService.request(
                    CompanyEndPoint.getCompany
                )
                
                self.companyListResponse = companyListResponse
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    fetchCompanyListSuccess?()
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
            getPopularProduct()
        }
    }
}
