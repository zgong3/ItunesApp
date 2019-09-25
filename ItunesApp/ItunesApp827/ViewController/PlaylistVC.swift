//
//  PlaylistVC.swift
//  ItunesApp827
//
//  Created by Consultant on 9/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class PlaylistVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    
    var audioPlayer: AVAudioPlayer!
    var previousSelected: Int?
    var viewModel: ViewModel!
    

    var tracks = [Track]() {
        didSet {
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tracks = core.load()
        
    }
    
    
    var names : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblList.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func previewButtonTapped(sender: UIButton) {
        
        let track = tracks[sender.tag]
   
        if previousSelected != nil && sender.tag != previousSelected {
            tblList.reloadRows(at: [IndexPath(row: previousSelected!, section: 1)], with: .top)
        }
        
        switch sender.currentImage == #imageLiteral(resourceName: "play") {
        case true:
            guard let endpoint = track.url, let url = URL(string: endpoint) else { return }
            //API Requests
            URLSession.shared.dataTask(with: url) { [weak self] (dat, _, _) in
                if let data = dat {
                    do {
                        DispatchQueue.main.async {
                            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                            self?.previousSelected = sender.tag
                        }
                        //Set AVPlayer with Data from API Request
                        self?.audioPlayer = try AVAudioPlayer(data: data)
                        //AudioPlayer to play
                        self?.audioPlayer.play()
                    } catch {
                        print("Couldn't Play Data: \(error.localizedDescription)")
                        return
                    }
                }
                }.resume()
            
        case false:
            previousSelected = nil
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            audioPlayer.pause()
        }
        
    }
    
    
    
}

extension PlaylistVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favcell.identifier, for: indexPath) as! favcell
        let track = tracks[indexPath.row]
        cell.trackName.text = track.name
        cell.track = track
        cell.trackPreviewButton.addTarget(self, action: #selector(previewButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    
    
}


extension PlaylistVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    

}
