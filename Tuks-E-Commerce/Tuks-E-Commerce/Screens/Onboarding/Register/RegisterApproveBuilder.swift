final class RegisterApproveBuilder {
    static func build(userId: Int) -> RegisterApproveController {
        let networkService = DefaultNetworkService()
        let viewModel = RegisterApproveViewModel(networkService: networkService, userId: userId)
        return RegisterApproveController(viewModel: viewModel)
    }
}
