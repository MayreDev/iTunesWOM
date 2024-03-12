import UIKit

class HomeViewDelegate: NSObject {
     weak var view: HomeViewProtocol?
}

extension HomeViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let song = view?.ListTunes?.results[indexPath.row] else { return }
        view?.goToDetail(song: song)
    }
}
