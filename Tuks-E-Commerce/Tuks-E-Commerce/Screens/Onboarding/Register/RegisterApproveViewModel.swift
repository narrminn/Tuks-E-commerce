import Foundation

final class RegisterApproveViewModel {
    let userId: Int
    let networkService: NetworkService
    
    var approveSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService, userId: Int) {
        self.networkService = networkService
        self.userId = userId
    }
    
    func registerApprove(body: RegisterApproveRequest) {
        Task {
            do {
                let response: SuccessResponse = try await networkService.request(
                    OnboardingEndPoint.registerApprove(userId: userId, body: body)
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.approveSuccess?()
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
