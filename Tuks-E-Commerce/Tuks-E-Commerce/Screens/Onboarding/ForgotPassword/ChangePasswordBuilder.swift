final class ChangePasswordBuilder {
    static func build(email: String) -> ChangePasswordController {
        let networkService = DefaultNetworkService()
        let viewModel = ChangePasswordViewModel(email: email, networkService: networkService)
        return ChangePasswordController(viewModel: viewModel)
    }
}
