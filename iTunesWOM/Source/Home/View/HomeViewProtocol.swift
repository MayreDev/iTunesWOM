import UIKit

protocol HomeViewProtocol: AnyObject, LoardingSpinnerView, ErrorAlertDelegate, ErrorAlertView, TunesCellDelegate {
    var segmentedControl: UISegmentedControl { get }
    var ListTunes: TunesModel? { get }
    var favoriteTunes: [Result] { get set } 
    func getDataTunes(_ model: TunesModel)
    func goToDetail(song: Result)
}
