import Foundation

final class LoginViewModel {
    let networkService: NetworkService
    
    var loginSuccess: ((LoginResponseData) -> Void)?
    var errorHandling: ((String) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func login(body: LoginRequest) {
        Task {
            do {
                
                let loginResponse: LoginResponse = try await networkService.request(
                    OnboardingEndPoint.login(body: body)
                )
                                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    guard let data = loginResponse.data else { return }

                    self.loginSuccess?(data)
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
