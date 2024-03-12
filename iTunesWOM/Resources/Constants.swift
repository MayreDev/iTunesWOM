import UIKit

class Constants {
    enum Splash {
        static let image = "SplashITunes"
        static let timerSplash = 5.0
    }
    
    enum Loarding {
        static let tag = 123
    }
    
    enum Alert {
        static let title = "Error"
        static let message = "Lo sentimos, ocurrió un error inesperado. Por favor, intenta nuevamente."
        static let retryButton = "Reintentar"
        static let closeAppButton = "Cerrar aplicación"
    }
    
    enum NetworkRest {
        static let url = "https://itunes.apple.com/search?term=pop&country=us&entity=song&limit=10"
    }
    
    enum HomeView {
        static let navigationTitle = "iTunes"
        static let segmentedTexts = ["Todos", "Favoritos"]
    }
    
    enum TunesCell {
        static let nameCell = "TunesCell"
        static let heart = "heart"
        static let heartFill = "heart.fill"
        static let borderWidth: CGFloat = 1.0
        static let albumImageViewWidth: CGFloat = 60.0
        static let albumImageViewHeight: CGFloat = 60.0
    }
    
    enum Numbers {
        static let teen = 10
        static let two = 2
    }
    
    enum Size {
        static let sixteen = 16
        static let fourteen = 14
    }
    
    enum Constraints {
        static let containerViewTop: CGFloat = 10.0
        static let containerViewLeading: CGFloat = 10.0
        static let containerViewTrailing: CGFloat = -10.0
        static let containerViewBottom: CGFloat = -10.0
        
        static let trackNameLabelTop: CGFloat = 10.0
        static let trackNameLabelLeading: CGFloat = 10.0
        static let trackNameLabelTrailing: CGFloat = -10.0
        
        static let artistNameLabelTop: CGFloat = 5.0
        static let artistNameLabelLeading: CGFloat = 10.0
        static let artistNameLabelTrailing: CGFloat = -10.0
        
        static let albumImageViewTop: CGFloat = 10.0
        static let albumImageViewLeading: CGFloat = 10.0
        static let albumImageBottom: CGFloat = -10.0
        
        static let favoriteButtonTop: CGFloat = 10.0
        static let favoriteButtonTrailing: CGFloat = -10.0
    }
    
    enum UserDefault {
        static let favoriteId = "favoriteTrackIDs"
    }
}
