import Foundation

final class BasketViewModel {
    let networkService: NetworkService
    
    var addToBasketSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func addToBasket(body: AddToBasketRequest) {
        Task {
            
            do {
                let _ : SuccessResponse = try await networkService.request(
                    ProductEndPoint.addToBasket(body: body)
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.addToBasketSuccess?()
                }
            }
            
            catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.errorHandling?(error.localizedDescription)
                }
            }
        }
    }
}
