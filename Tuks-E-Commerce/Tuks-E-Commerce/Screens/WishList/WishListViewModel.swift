import Foundation

final class WishListViewModel {
    let networkService: NetworkService
    
    var errorHandling: ((String) -> Void)?

    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func addWishlist(id: Int) {
        Task {
            do {
                let _ : SuccessResponse = try await networkService.request(
                    ProductEndPoint.addWishlist(id: id)
                )
                
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    errorHandling?(error.localizedDescription)
                }
            }
        }
    }
}
