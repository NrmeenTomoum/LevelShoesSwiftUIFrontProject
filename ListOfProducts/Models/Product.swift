//
//  ProductModel.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//
import Foundation
extension Product: Hashable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Product: Codable, Identifiable {
    var id: String
    var name: String
    var originalPrice: String
    var salePrice: String
    var image: ImageModel
    var description: String?
    var isFavorite: Bool = false
    var brandName: String
    var badges: [Badge]
    var discountPercentage: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case originalPrice
        case salePrice
        case image
        case description
        case isFavorite
        case brandName
        case badges
        case discountPercentage
    }
    
    init(id: String, name: String, originalPrice: String, salePrice: String, image: ImageModel, description: String? = nil, isFavorite: Bool, brandName: String, badges: [Badge], discountPercentage: String? = nil) {
        self.id = id
        self.name = name
        self.originalPrice = originalPrice
        self.salePrice = salePrice
        self.image = image
        self.description = description
        self.isFavorite = isFavorite
        self.brandName = brandName
        self.badges = badges
        self.discountPercentage = discountPercentage
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        originalPrice = try container.decode(String.self, forKey: .originalPrice)
        image = try container.decode(ImageModel.self, forKey: .image)
        salePrice = try container.decodeIfPresent(String.self, forKey: .salePrice) ?? originalPrice
        description = try container.decodeIfPresent(String.self, forKey: .description)
        brandName = try container.decode(String.self, forKey: .brandName)
        badges = try container.decode([Badge].self, forKey: .badges)
        discountPercentage = try container.decodeIfPresent(String.self, forKey: .discountPercentage)
        isFavorite = false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(originalPrice, forKey: .originalPrice)
        try container.encode(salePrice, forKey: .salePrice)
        try container.encode(image, forKey: .image)
        try container.encode(description ?? "", forKey: .description)
        try container.encode(brandName, forKey: .brandName)
        try container.encode(badges, forKey: .badges)
        try container.encode(discountPercentage ?? "0", forKey: .discountPercentage)
    }
}

enum TextType: String, Codable {
    case empty = "★"
    case exclusive = "EXCLUSIVE"
    case globalExclusive = "GLOBAL EXCLUSIVE"
    case new = "NEW"
    case onlineExclusive = "ONLINE EXCLUSIVE"
    case preLaunch = "PRE-LAUNCH"
}

struct Badge: Codable, Identifiable {
    var id: UUID = UUID()
    let text: TextType
    
    enum CodingKeys: String, CodingKey {
        case text
    }
    init(text: TextType) {
        self.text = text
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(TextType.self, forKey: .text)
        id = UUID() // Generate a unique ID since it's not in the JSON
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
    }
    
}


struct ImageModel: Codable, Identifiable {
    var id: UUID = UUID()
    var url: String
    var height: Int
    var width: Int
    var gender: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case url
        case height
        case width
        case gender
    }
    init(_ url: String, height: Int, width: Int, gender: String? = nil) {
        self.url = url
        self.height = height
        self.width = width
        self.gender = gender
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID() // Generate a unique ID since it's not in the JSON
        url = try container.decode(String.self, forKey: .url)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
        try container.encodeIfPresent(gender, forKey: .gender)
    }
}

