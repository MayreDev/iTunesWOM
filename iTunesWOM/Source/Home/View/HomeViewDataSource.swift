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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TunesCell", for: indexPath) as? TunesCell
        else {return UITableViewCell()}
        
        guard let song = view?.ListTunes?.results[indexPath.row] else { return UITableViewCell() }
      
        cell.setup(song: song)
        return cell
    }
}
