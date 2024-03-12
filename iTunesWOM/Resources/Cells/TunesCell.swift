import UIKit
import Kingfisher

protocol TunesCellDelegate: AnyObject {
    func didTapFavoriteButton(_ cell: TunesCell)
}

class TunesCell: UITableViewCell {
    private let containerView = UIView()
    private let trackNameLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let albumImageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)

    weak var delegate: TunesCellDelegate?

    var isFavorite: Bool = false {
        didSet {
            updateFavoriteButtonImage()
        }
    }

    var trackId: Int = .zero

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }

    func setup(song: Result) {
        trackId = song.trackID
        trackNameLabel.text = song.trackName
        artistNameLabel.text = song.artistName
        if let url = URL(string: song.artworkUrl100) {
            albumImageView.kf.setImage(with: url)
        }
        isFavorite = UserDefaults.standard.bool(forKey: "\(trackId)")
        updateFavoriteButtonImage()
    }

    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        updateFavoriteButtonImage()
        delegate?.didTapFavoriteButton(self)
        UserDefaults.standard.set(isFavorite, forKey: "\(trackId)")
    }

    private func updateFavoriteButtonImage() {
        let imageName = isFavorite ? Constants.TunesCell.heartFill : Constants.TunesCell.heart
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    private func prepare() {
        configureContainerView()
        configureTrackNameLabel()
        configureArtistNameLabel()
        configureAlbumImageView()
        configureFavoriteButton()
        configureLayout()
    }

    private func configureContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = CGFloat(Constants.Numbers.teen)
        containerView.layer.borderWidth = Constants.TunesCell.borderWidth
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }

    private func configureTrackNameLabel() {
        trackNameLabel.font = UIFont.systemFont(ofSize: CGFloat(Constants.Size.sixteen), weight: .bold)
        trackNameLabel.numberOfLines = Constants.Numbers.two
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(trackNameLabel)
    }

    private func configureArtistNameLabel() {
        artistNameLabel.font = UIFont.systemFont(ofSize: CGFloat(Constants.Size.fourteen), weight: .regular)
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

    private func configureFavoriteButton() {
        favoriteButton.setImage(UIImage(systemName: Constants.TunesCell.heart), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(favoriteButton)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.containerViewTop),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.containerViewLeading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.Constraints.containerViewTrailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Constraints.containerViewBottom),

            trackNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Constraints.trackNameLabelTop),
            trackNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: Constants.Constraints.trackNameLabelLeading),
            trackNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.Constraints.trackNameLabelTrailing),

            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: Constants.Constraints.artistNameLabelTop),
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: Constants.Constraints.artistNameLabelLeading),
            artistNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.Constraints.artistNameLabelTrailing),

            albumImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Constraints.albumImageViewTop),
            albumImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.Constraints.albumImageViewLeading),
            albumImageView.widthAnchor.constraint(equalToConstant: Constants.TunesCell.albumImageViewWidth),
            albumImageView.heightAnchor.constraint(equalToConstant: Constants.TunesCell.albumImageViewHeight),
            albumImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: Constants.Constraints.albumImageBottom),

            favoriteButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Constraints.favoriteButtonTop),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.Constraints.favoriteButtonTrailing)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
