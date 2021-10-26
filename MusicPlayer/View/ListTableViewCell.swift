//
//  ListTableViewCell.swift
//  MusicPlayer
//
//  Created by 林煜凱 on 10/25/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(with: SongData) {
        albumImageView.layer.cornerRadius = 5
        albumImageView.layer.masksToBounds = true
        if let albumImage = UIImage(named: with.albumImage) {
        albumImageView.image = albumImage
        }
        songTitleLabel.text = with.songTitle
        singerNameLabel.text = with.singer
    }
}
