import UIKit
import Kingfisher

class TunesCell: UITableViewCell {
    private let containerView = UIView()
    private let trackNameLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let albumImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }

    func setup(song: Result) {
        trackNameLabel.text = song.trackName
        artistNameLabel.text = song.artistName
        if let url = URL(string: song.artworkUrl100) {
            albumImageView.kf.setImage(with: url)
        }
    }

    private func prepare() {
        configureContainerView()
        configureTrackNameLabel()
        configureArtistNameLabel()
        configureAlbumImageView()
        configureLayout()
    }

    private func configureContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }

    private func configureTrackNameLabel() {
        trackNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        trackNameLabel.numberOfLines = 2
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(trackNameLabel)
    }

    private func configureArtistNameLabel() {
        artistNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        artistNameLabel.textColor = .gray
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(artistNameLabel)
    }

    private func configureAlbumImageView() {
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.clipsToBounds = true
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(albumImageView)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            trackNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            trackNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10),
            trackNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 5),
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10),
            artistNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            albumImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            albumImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            albumImageView.widthAnchor.constraint(equalToConstant: 60),
            albumImageView.heightAnchor.constraint(equalToConstant: 60),
            albumImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
