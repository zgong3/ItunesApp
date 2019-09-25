//
//  PlaylistCoredata.swift
//  ItunesApp827
//
//  Created by Consultant on 9/25/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData

let core = PlaylistCoredata.shared

final class PlaylistCoredata {
    
    static let shared = PlaylistCoredata()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PlaylistCoredata")
        container.loadPersistentStores(completionHandler: { (storeDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
    }()
    
    func save(_ track: Track) {
        
        let entity = NSEntityDescription.entity(forEntityName: "CoreTrack", in: context)!
        let core = CoreTrack(entity: entity, insertInto: context)
        
        if let duration = track.duration  {
             core.setValue(Int64(duration), forKey: "duration")
        }


        

        
        core.setValue(track.name, forKey: "name")
        core.setValue(track.price, forKey: "price")
      
        core.setValue(track.image, forKey: "image")
        core.setValue(track.url, forKey: "url")
        core.setValue(track.releaseDate, forKey: "releaseDate")
        
        print("Saved Fact To Core: \(track.name)")
        
        
    }
    
    func load() -> [Track] {
        
        let fetchRequest = NSFetchRequest<CoreTrack>(entityName: "CoreTrack")
        
        var tracks = [Track]()
        
        do {
            let coreTracks = try context.fetch(fetchRequest)
            for core in coreTracks {
                tracks.append(Track(core: core))
                
            }
            
        } catch {
            print("Couldn't Fetch Fact: \(error.localizedDescription)")
        }
        
        return tracks
    }
    
    
    
    
    
}
