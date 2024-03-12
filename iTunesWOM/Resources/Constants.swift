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
    }
}
