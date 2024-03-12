protocol HomeViewProtocol: AnyObject, LoardingSpinnerView, ErrorAlertDelegate, ErrorAlertView  {
    var ListTunes: TunesModel? { get } 
    func getDataTunes(_ model: TunesModel)
}
