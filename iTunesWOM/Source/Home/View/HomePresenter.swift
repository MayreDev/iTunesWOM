import UIKit

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    private let useCase: TunesUseCase
    
    init(useCase: TunesUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    func getListModel() async {
        view?.showSpinner()
        do {
            let model = try await getData()
            view?.getDataTunes(model)
        } catch {
            view?.showErrorAlert(
                message: Constants.Alert.message,
                retryButtonText: Constants.Alert.retryButton,
                closeAppButtonText: Constants.Alert.closeAppButton,
                retryDelegate: view
            )
        }
        view?.hiddenSpinner()
    }
    
    private func getData() async throws -> TunesModel {
        let model = try await useCase.getListTunesModel()
        return model
    }
}
