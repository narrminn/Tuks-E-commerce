import Foundation

final class ForgotPasswordViewModel {
    let networkService: NetworkService
    
    var forgotPasswordSuccess: ((String) -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func forgotPassword(body: ForgotPasswordRequest) {
        Task {
            do {
                let _: SuccessResponse = try await networkService.request(
                    OnboardingEndPoint
                        .forgotPassword(body: body)
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.forgotPasswordSuccess?(body.email)
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
