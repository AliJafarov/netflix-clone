//
//  YoutubeResult.swift
//  NetflixCloneApp
//
//  Created by Ali Jafarov on 13.04.22.
//

import Foundation

struct YoutubeResult: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
