//
//  TrackCell.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/24/20.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String? { get }
}

class TrackCell : UITableViewCell {
    
    static let reuseID = "TrackCell"
    
    @IBOutlet weak var TrackImageView: UIImageView!
    @IBOutlet weak var TrackNameLabel: UILabel!
    @IBOutlet weak var ArtistNameLabel: UILabel!
    @IBOutlet weak var CollectionNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        TrackImageView.image = nil
    }
    
    func set(viewModel: TrackCellViewModel) {
        TrackNameLabel.text = viewModel.trackName
        ArtistNameLabel.text = viewModel.artistName
        CollectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        TrackImageView.sd_setImage(with: url, completed: nil)
    }
    
}
