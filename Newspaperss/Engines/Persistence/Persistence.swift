//
//  Persistence.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let urls = [
            "https://www.nu.nl/rss/Algemeen",
            "https://www.nu.nl/rss/Economie",
            "https://www.nu.nl/rss/Sport",
            "https://www.nu.nl/rss/Achterklap",
            "https://www.nu.nl/rss/Opmerkelijk",
            "https://www.nu.nl/rss/Opmerkelijk",
            "https://www.nu.nl/rss/Film",
            "https://www.nu.nl/rss/Wetenschap",
            "https://www.nu.nl/rss/Tech",
            "https://www.nu.nl/rss/Gezondheid"
        ].map { NSURL(string: $0)! }
        for url in urls.enumerated() {
            let newItem = RSSFeedItem(context: viewContext)
            newItem.url = url.element
            newItem.sortValue = Double(url.offset)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Newspaperss")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
