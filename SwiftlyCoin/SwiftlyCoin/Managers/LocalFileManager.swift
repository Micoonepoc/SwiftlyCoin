//
//  LocalFileManager.swift
//  SwiftlyCoin
//
//  Created by Михаил on 27.12.2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    private init() { }
    
    func saveImages(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getImageURL(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image \(imageName) \(error)")
        }
    }
    
    private func createFolderIfNeeded(folderName: String) {
        
        guard let url = getFolderURL(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory \(folderName) \(error)")
            }
        }
        
    }
    
    private func getFolderURL(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: folderName)
        
    }
    
    func getImageURL(imageName: String, folderName: String) -> URL? {
        
        guard let folderURL = getFolderURL(folderName: folderName) else {
            return nil
        }
        return folderURL.appending(path: imageName + ".png")
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getImageURL(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
}
