
import UIKit

class SplashViewController: UIViewController {
    
    private let logoImage = UIImageView()
    private var timerSplash = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImages()
        configureTimerSplash()
        configureLayout()
    }
    
    func configureImages(){
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.contentMode = .scaleAspectFill
        logoImage.image = UIImage(named: SplashViewControllerConstants.Logo.image)
        view.addSubview(logoImage)
    }

    func configureTimerSplash(){
        timerSplash = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            let viewController = HomeViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func configureLayout(){
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}