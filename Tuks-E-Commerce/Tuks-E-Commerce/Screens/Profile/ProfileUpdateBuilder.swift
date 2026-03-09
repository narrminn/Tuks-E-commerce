final class ProfileUpdateBuilder {
    static func build() -> ProfileUpdateViewController {
        let networkService = DefaultNetworkService()
        let viewModel = ProfileViewModel(networkService: networkService)
        let fileViewModel = FileUploadViewModel(networkService: networkService)
        return ProfileUpdateViewController(viewModel: viewModel, fileViewModel: fileViewModel)
    }
}
