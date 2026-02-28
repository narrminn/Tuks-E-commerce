import Foundation

final class FileUploadViewModel {
    let networkService: NetworkService
    
    var photoUploadSuccess: ((FileUploadResponse) -> Void)?
    var errorHandling: ((String) -> Void)?

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func photoUpload(data: Data) {
        Task {
            do {
                let response: FileUploadResponse = try await networkService
                    .request(FileUploadEndPoint.fileUpload(data: data))
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    photoUploadSuccess?(response)
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    errorHandling?(error.localizedDescription)
                }
            }
        }
    }
}
