//
//  FolderViewModel.swift
//  MI_Practical
//
//  Created by SLS M2 on 20/12/23.
//

import Foundation

class FolderViewModel {
    var currentFolder: String = "Document"
    var folderCount: Int = 0
    var folders: [Folder] = []
    var navigateBackClosure: (() -> Void)?
    func generateFolders() {
        folders.removeAll()

        for _ in 1...3 {
            folderCount += 1
            let newFolderName = "\(currentFolder)_\(folderCount)"
            let folder = Folder(name: newFolderName, url: createFolderInDocumentDirectory(folderName: newFolderName))
            folders.append(folder)
        }
    }

    func createFolderInDocumentDirectory(folderName: String) -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let newFolderURL = documentDirectory.appendingPathComponent(folderName)

        do {
            try FileManager.default.createDirectory(at: newFolderURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
        }

        return newFolderURL
    }
    
    func handleBackButton() {
      
          if currentFolder != "Document" {
              let components = currentFolder.components(separatedBy: "_")
              if components.count > 1 {
                  currentFolder = components.dropLast().joined(separator: "_")
                  folderCount = 0
                  generateFolders()
              } else {
                  currentFolder = "Document"
                  folderCount = 0
                  generateFolders()
              }
          } else {
              navigateBackClosure?()
          }
      }
}
