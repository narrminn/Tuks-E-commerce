final class LoginBuilder {
    static func build() -> LoginController {
        let networkService = DefaultNetworkService()
        let viewModel = LoginViewModel(networkService: networkService)
        return LoginController(viewModel: viewModel)
    }
}
