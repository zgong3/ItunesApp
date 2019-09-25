//
//  favcell.swift
//  ItunesApp827
//
//  Created by Consultant on 9/25/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class favcell: UITableViewCell {

    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var trackPreviewButton: UIButton!
    
    
    
    static let identifier = "favcell"
    
    var track: Track! {
        didSet {
            trackName.text = track.name
            trackDuration.text = track.duration!.toMinutes
            trackPrice.text = "$\(track.price!)"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackPreviewButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        trackPreviewButton.setImage(#imageLiteral(resourceName: "pause"), for: .selected)
    }

}
