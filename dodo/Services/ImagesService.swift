//
//  ImagesService.swift
//  dodo
//
//  Created by Юлия Ястребова on 23.01.2025.
//

import Foundation
import Nuke


enum ImageError: Error {
    case invalidURL
}

class ImagesService {
    func loadImage(url: String) async throws -> PlatformImage {
        guard let url = URL.init(string: url) else { throw ImageError.invalidURL }
        let imageTask = ImagePipeline.shared.imageTask(with: url)
        for await progress in imageTask.progress {
            // Update progress
        }
        //imageView.image = try await imageTask.image
        
        return try await imageTask.image
    }
}
