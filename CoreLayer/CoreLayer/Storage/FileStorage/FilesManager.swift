//
//  FilesManager.swift
//  CoreLayer
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import Foundation

class FilesManager: IFileStorage {
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func returnName(fileName: String)->String?{
        
        
        if   let name =   fileName.split(separator: "/").last {
            return String(name )
        }
        else{
         return  nil
        }
        
     
        
    }
    
    func loadImage(fileName: String) -> UIImage? {
       
        
        guard let name = returnName(fileName: fileName) else {
          return nil
        }
       
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(name)")
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
 
        }
        return nil
    }
    
    func saveImage(image: UIImage, fileName: String)  {
        guard let name = returnName(fileName: fileName) else {
            return 
        }
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("\(name)")
            do {
                try data.write(to: filename)
            } catch {
                print("Error save image : \(error)")
            }
        }
    }
}
