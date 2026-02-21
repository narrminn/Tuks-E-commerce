import Foundation

struct CompanyListResponse: Codable {
    let message: String?
    let data: CompanyListData?
}

struct CompanyListData: Codable {
    let companies: [Company]?
}

struct Company: Codable {
    let id: Int?
    let name, slug: String?
    let logo: String?
}
