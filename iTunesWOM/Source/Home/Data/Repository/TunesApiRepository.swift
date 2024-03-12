import UIKit

final class TunesApiRepository: TunesRepository {
    let restApi: TunesRestApi
    
    init(restApi: TunesRestApi) {
        self.restApi = restApi
    }
    
    func listTunes() async throws -> TunesModel {
        do {
            let model = try await restApi.listTunes()
            return model
        } catch {
            throw URLError(.badURL)
        }
    }
}
