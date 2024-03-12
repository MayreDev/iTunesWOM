import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    private let stackView = UIStackView()
    private let albumImageView = UIImageView()
    private let artistNameLabel = UILabel()
    private let trackNameLabel = UILabel()
    private let durationLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let genreLabel = UILabel()
    private let priceLabel = UILabel()
    private let trackCountLabel = UILabel()
    private let discNumberLabel = UILabel()
    private let ratingLabel = UILabel()

    var song: Result?
    
    convenience init(song: Result?) {
        self.init()
        self.song = song
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detalles"
        setupStackView()
        setupAlbumImageView()
        setupArtistNameLabel()
        setupTrackNameLabel()
        setupDurationLabel()
        setupReleaseDateLabel()
        setupGenreLabel()
        setupPriceLabel()
        setupTrackCountLabel()
        setupDiscNumberLabel()
        setupRatingLabel()

        if let song = song {
            updateUI(with: song)
        }
        setupConstraints()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
    }

    private func setupAlbumImageView() {
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.layer.cornerRadius = 50
        albumImageView.clipsToBounds = true
        stackView.addArrangedSubview(albumImageView)
    }

    private func setupArtistNameLabel() {
        artistNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        artistNameLabel.textAlignment = .left
        stackView.addArrangedSubview(artistNameLabel)
    }

    private func setupTrackNameLabel() {
        trackNameLabel.font = UIFont.systemFont(ofSize: 18)
        trackNameLabel.textAlignment = .left
        stackView.addArrangedSubview(trackNameLabel)
    }

    private func setupDurationLabel() {
        durationLabel.font = UIFont.systemFont(ofSize: 16)
        durationLabel.textAlignment = .left
        stackView.addArrangedSubview(durationLabel)
    }

    private func setupReleaseDateLabel() {
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.textAlignment = .left
        stackView.addArrangedSubview(releaseDateLabel)
    }

    private func setupGenreLabel() {
        genreLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.textAlignment = .left
        stackView.addArrangedSubview(genreLabel)
    }

    private func setupPriceLabel() {
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.textAlignment = .left
        stackView.addArrangedSubview(priceLabel)
    }

    private func setupTrackCountLabel() {
        trackCountLabel.font = UIFont.systemFont(ofSize: 16)
        trackCountLabel.textAlignment = .left
        stackView.addArrangedSubview(trackCountLabel)
    }

    private func setupDiscNumberLabel() {
        discNumberLabel.font = UIFont.systemFont(ofSize: 16)
        discNumberLabel.textAlignment = .left
        stackView.addArrangedSubview(discNumberLabel)
    }

    private func setupRatingLabel() {
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textAlignment = .left
        stackView.addArrangedSubview(ratingLabel)
    }

    private func updateUI(with song: Result) {
        artistNameLabel.attributedText = attributedText("Artista:", value: song.artistName)
        trackNameLabel.attributedText = attributedText("Canción:", value: song.trackName)
        durationLabel.attributedText = attributedText("Duración:", value: formatDuration(song.trackTimeMillis))
        releaseDateLabel.attributedText = attributedText("Fecha de lanzamiento:", value: formatReleaseDate(song.releaseDate))
        genreLabel.attributedText = attributedText("Género:", value: song.primaryGenreName.rawValue)
        priceLabel.attributedText = attributedText("Precio:", value: "\(song.trackPrice ?? 0) \(song.currency.rawValue)")
        trackCountLabel.attributedText = attributedText("Número de canciones:", value: "\(song.trackCount)")
        discNumberLabel.attributedText = attributedText("Número de discos:", value: "\(song.discNumber)")
        ratingLabel.attributedText = attributedText("Rating:", value: song.contentAdvisoryRating ?? "No disponible")

        if let artworkUrl = URL(string: song.artworkUrl100) {
            albumImageView.kf.setImage(with: artworkUrl)
        }
    }

    private func formatDuration(_ milliseconds: Int) -> String {
        let seconds = Int(Double(milliseconds) / 1000.0)
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    private func formatReleaseDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return dateString
        }
    }

    private func attributedText(_ key: String, value: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(key) ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedString.append(NSAttributedString(string: value, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        return attributedString
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            albumImageView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}
