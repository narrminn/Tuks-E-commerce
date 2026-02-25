import Foundation

final class ProfileViewModel {
    var fileUploadResponse: FileUploadResponse?
    
    let networkService: NetworkService
    
    var photoUpdateSuccess: (() -> Void)?
    var errorHandling: ((String) -> Void)?
        
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func updateProfile(name: String, surname: String, phone: String, birth: String?) {
        var profilePhoto: ProfilePhoto? = nil
        
        if fileUploadResponse != nil {
            profilePhoto = ProfilePhoto(
                fileUUID: fileUploadResponse?.data?.file?.id,
                filePath: fileUploadResponse?.data?.file?.path
            )
        }
        
        var request = ProfileUpdateRequest(
            name: name,
            surname: surname,
            phone: phone,
            birth: birth,
            profilePhoto: profilePhoto
        )
        
        Task {
            do {
                let _: SuccessResponse = try await networkService
                    .request(ProfileUpdateEndPoint.updateProfile(body: request))
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.photoUpdateSuccess?()
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
