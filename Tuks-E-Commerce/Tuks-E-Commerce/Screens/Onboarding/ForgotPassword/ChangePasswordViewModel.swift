import Foundation

final class ChangePasswordViewModel {
    let email: String
    
    let networkService: NetworkService
    
    var changePasswordSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(email: String, networkService: NetworkService) {
        self.networkService = networkService
        self.email = email
    }
    
    func confirmPassword(body: ForgotPasswordConfirmRequest) {
        Task {
            do {
                
                let _ : SuccessResponse = try await networkService.request(
                    OnboardingEndPoint.forgotPasswordConfirm(body: body)
                )
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.changePasswordSuccess?()
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
