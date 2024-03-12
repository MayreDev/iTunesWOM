import UIKit

class HomeViewDataSource: NSObject {
     weak var view: HomeViewProtocol?
}

extension HomeViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let view = view else { return 0 }
        
        switch view.segmentedControl.selectedSegmentIndex {
        case 0:
            return view.ListTunes?.resultCount ?? 0
        case 1:
            return view.favoriteTunes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TunesCell.nameCell, for: indexPath) as? TunesCell else {
            return UITableViewCell()
        }
        
        switch view?.segmentedControl.selectedSegmentIndex {
        case 0:
            guard let song = view?.ListTunes?.results[indexPath.row] else { return UITableViewCell() }
            cell.setup(song: song)
        case 1:
            guard let favoriteSong = view?.favoriteTunes[indexPath.row] else { return UITableViewCell() }
            cell.setup(song: favoriteSong)
        default:
            break
        }
        cell.delegate = view
        return cell
    }
}
