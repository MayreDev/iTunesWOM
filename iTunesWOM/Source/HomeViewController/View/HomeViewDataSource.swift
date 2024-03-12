import UIKit

class HomeViewDataSource: NSObject {
     weak var view: HomeViewProtocol?
}

extension HomeViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let view = view?.ListTunes?.resultCount else { return .zero}
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view = view?.ListTunes?.results else { return UITableViewCell() }
        let cell = UITableViewCell()
        return cell
    }
}
