import UIKit

class TunesNetworkRestApi: TunesRestApi {
    func listTunes() async throws -> TunesModel {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        guard let url = URL(string: Constants.NetworkRest.url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await urlSession.data(from: url)
        
        do {
            let products = try JSONDecoder().decode(TunesModel.self, from: data)
            return products
        } catch {
            throw error
        }
        
    }
    
}
