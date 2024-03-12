final class TunesUseCase {
    let repository: TunesRepository
    
    init(repository: TunesRepository) {
        self.repository = repository
    }
    
    func getListTunesModel() async throws -> TunesModel {
        let response = try await repository.listTunes()
        return response
    }
}
