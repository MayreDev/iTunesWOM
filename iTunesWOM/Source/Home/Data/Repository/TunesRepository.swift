protocol TunesRepository{
    func listTunes() async throws -> TunesModel
}
