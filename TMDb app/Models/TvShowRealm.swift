//
//  TvShowRealm.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//


import Foundation
import RealmSwift

class TvShowRealm: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath = ""
    @objc dynamic var mediaType = ""
    @objc dynamic var posterPath = ""

}
