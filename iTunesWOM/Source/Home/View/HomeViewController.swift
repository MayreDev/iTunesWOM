import UIKit

class HomeViewController: UIViewController {
    
    private var tableView = UITableView()
    var ListTunes: TunesModel?
    
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
        configureTableView()
        configureLayout()
    }
    
    private func getListTunes() {
        Task {
            await presenter?.getListModel()
        }
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TunesCell.self, forCellReuseIdentifier: "TunesCell")
        tableView.dataSource = viewDataSource
        tableView.delegate = viewDelegate
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewProtocol {
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
