import UIKit

protocol LoardingSpinnerView: AnyObject {
    func showSpinner()
    func hiddenSpinner()
}

extension LoardingSpinnerView where Self : UIViewController{
    func showSpinner(){
        let containerView = UIView()
        let spinner = UIActivityIndicatorView(style: .large)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .purple
        
        containerView.addSubview(spinner)
        
        containerView.tag = Constants.Loarding.tag
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
        containerView.backgroundColor = .white
        spinner.startAnimating()
    }
    
    func hiddenSpinner(){
        if let removed = self.view.viewWithTag(Constants.Loarding.tag){
            removed.removeFromSuperview()
        }
    }
}
