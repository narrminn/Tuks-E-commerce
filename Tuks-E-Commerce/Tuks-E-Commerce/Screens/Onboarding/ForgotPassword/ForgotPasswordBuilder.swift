final class ForgotPasswordBuilder {
    static func build() -> ForgotPasswordController {
        let networkService = DefaultNetworkService()
        let viewModel = ForgotPasswordViewModel(networkService: networkService)
        return ForgotPasswordController(viewModel: viewModel)
    }
}
