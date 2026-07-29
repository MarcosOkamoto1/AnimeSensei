//
//  Anime.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 28/07/26.
//

import Foundation

public struct Anime: Identifiable,Codable{
    public let id: Int
    let title: String
    let description: String?
    let episodes : Int?
    let genres : [String]
    let averageScore : Int?
    let coverImage: String?
}
