import Foundation

final class BasketViewModel {
    let networkService: NetworkService
    
    var addToBasketSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    var getBasketItemsSuccess: (() -> Void)?
    
    var basketItems: [BasketItem] = []
    var totalPrice: Int = 0
    
    var deleteBasketItemSuccess: (() -> Void)?
    var checkoutSuccess: (() -> Void)?

    
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
    
    
    func getBasketItems() {
        Task {
            do {
                let response: BasketResponse = try await networkService.request(
                    ProductEndPoint.getBasketItems
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.basketItems = response.data?.items ?? []
                    self.totalPrice = response.data?.totalPrice ?? 0
                    self.getBasketItemsSuccess?()
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.errorHandling?(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteBasketItem(basketId: Int) {
        Task {
            do {
                let _: SuccessResponse = try await networkService.request(
                    ProductEndPoint.deleteBasketItem(id: basketId)
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.deleteBasketItemSuccess?()
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.errorHandling?(error.localizedDescription)
                }
            }
        }
    }
    
    
    func checkout() {
        Task {
            do {
                let _: SuccessResponse = try await networkService.request(
                    ProductEndPoint.checkout
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.checkoutSuccess?()
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.errorHandling?(error.localizedDescription)
                }
            }
        }
    }
}
