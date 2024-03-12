import UIKit

class HomeViewController: UIViewController {
    var segmentedControl = UISegmentedControl()
    private var tableView = UITableView()
    var ListTunes: TunesModel?
    var favoriteTunes: [Result] = []
    
    private var viewDataSource: HomeViewDataSource?
    private var viewDelegate: HomeViewDelegate?
    private var presenter: HomePresenter?
    
    convenience init(viewDataSource: HomeViewDataSource, viewDelegate: HomeViewDelegate, presenter: HomePresenter) {
        self.init()
        self.viewDataSource = viewDataSource
        self.viewDataSource?.view = self
        self.viewDelegate = viewDelegate
        self.viewDelegate?.view = self
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.HomeView.navigationTitle
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        getListTunes()
        configureSegmentedControl()
        configureTableView()
        configureLayout()
    }
    
    private func getListTunes() {
        Task {
            await presenter?.getListModel()
        }
    }
    
    private func configureSegmentedControl() {
        segmentedControl = UISegmentedControl(items: Constants.HomeView.segmentedTexts)
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.subviews.forEach { subview in
            subview.backgroundColor = .systemGray6
        }
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.addTarget(self, action: #selector(hideTableAndShowCollection), for: .valueChanged)
        view.addSubview(segmentedControl)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(Constants.Size.fourteen), weight: .bold)], for: .selected)
    }
    
    @objc func hideTableAndShowCollection() {
        updatefavorites()
        tableView.reloadData()
    }
    
    func updatefavorites(){
        guard let list = ListTunes?.results else { return }
        let favorites = UserDefaults.standard.array(forKey: Constants.UserDefault.favoriteId) as? [Int]
        let favoriteTrackIDs = list.filter{ favorites?.contains($0.trackID) == true}
        favoriteTunes.removeAll()
        favoriteTunes = favoriteTrackIDs
    }
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TunesCell.self, forCellReuseIdentifier: Constants.TunesCell.nameCell)
        tableView.dataSource = viewDataSource
        tableView.delegate = viewDelegate
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: CGFloat(Constants.Numbers.teen)),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func didTapFavoriteButton(_ cell: TunesCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let song = ListTunes?.results[indexPath.row]
            toggleFavoriteStatus(for: song)
        case 1:
            let song = favoriteTunes[indexPath.row]
            toggleFavoriteStatus(for: song)
        default:
            break
        }
    }
    
    private func toggleFavoriteStatus(for song: Result?) {
        guard let song = song else { return }
        
        let isFavorite = UserDefaults.standard.bool(forKey: "\(song.trackID)")
        
        if isFavorite {
            favoriteTunes.removeAll { $0.trackID == song.trackID }
        } else {
            favoriteTunes.append(song)
        }
        
        let favoriteTrackIDs = favoriteTunes.map { $0.trackID }
        UserDefaults.standard.set(favoriteTrackIDs, forKey:  Constants.UserDefault.favoriteId)
        tableView.reloadData()
        if let favoriteTrackIDs = UserDefaults.standard.array(forKey:  Constants.UserDefault.favoriteId) as? [Int] {
            favoriteTunes = ListTunes?.results.filter { favoriteTrackIDs.contains($0.trackID) } ?? []
        }
    }
    
    func closeAppAction() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
    func retryAction() {
        getListTunes()
    }
    
    func getDataTunes(_ model: TunesModel) {
        ListTunes = model
        self.tableView.reloadData()
    }
    
    func goToDetail(song: Result) {
        let detailView = DetailViewController(song: song)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
