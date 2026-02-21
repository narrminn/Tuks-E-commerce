struct Meta: Codable {
    let total, page, limit, totalPage: Int?

    enum CodingKeys: String, CodingKey {
        case total, page, limit
        case totalPage = "total_page"
    }
}
