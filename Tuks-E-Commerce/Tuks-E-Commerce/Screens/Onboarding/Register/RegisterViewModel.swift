import Foundation

final class RegisterViewModel {
    var userId: Int?
    
    var userCreated: ((Int) -> Void)?
    var errorHandling: ((String) -> Void)?
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func registerSubmit(body: RegisterRequest) {
        Task {
            do {
                let response: RegisterResponse = try await networkService.request(
                    OnboardingEndPoint.register(body: body)
                )
                
                userId = response.data?.userID
                
                await MainActor.run { [weak self] in
                                        
                    guard let self else { return }
                    guard let userId = self.userId else { return }
                                
                    self.userCreated?(userId)
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    
                    guard let self else { return }
                    self.errorHandling?(
                        error.localizedDescription
                    )
                }
            }
        }
    }
}
