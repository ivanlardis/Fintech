//
//  FileManager.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class FileManager: NSObject {

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func loadImage(fileName: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(fileName).png")
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }

    private func saveImage(image: UIImage, fileName: String) -> Bool {
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("\(fileName).png")
            do {
                try data.write(to: filename)
                return true
            } catch {
                print("Error save image : \(error)")
                return false
            }

        } else {
            return false
        }
    }
}
