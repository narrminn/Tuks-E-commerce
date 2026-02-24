final class RegisterBuilder {
    static func build() -> RegisterController {
        let networkService = DefaultNetworkService()
        let viewModel = RegisterViewModel(networkService: networkService)
        return RegisterController(viewModel: viewModel)
    }
}
