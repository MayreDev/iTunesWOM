import UIKit

protocol ErrorAlertDelegate: AnyObject {
    func retryAction()
    func closeAppAction()
}

protocol ErrorAlertView: AnyObject {
    func showErrorAlert(message: String, retryButtonText: String, closeAppButtonText: String, retryDelegate: ErrorAlertDelegate?)
}

extension ErrorAlertView where Self: UIViewController {
    func showErrorAlert(message: String, retryButtonText: String, closeAppButtonText: String, retryDelegate: ErrorAlertDelegate?) {
        let alert = UIAlertController(title: Constants.Alert.title, message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: retryButtonText, style: .default) { _ in
            retryDelegate?.retryAction()
        }
        
        let closeAppAction = UIAlertAction(title: closeAppButtonText, style: .destructive) { _ in
            retryDelegate?.closeAppAction()
        }
        
        alert.addAction(retryAction)
        alert.addAction(closeAppAction)
        
        present(alert, animated: true, completion: nil)
    }
}
