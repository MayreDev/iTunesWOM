protocol TunesRestApi{
    func listTunes() async throws -> TunesModel
}
