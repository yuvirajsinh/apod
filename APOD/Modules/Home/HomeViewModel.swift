//
//  HomeViewModel.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import UIKit

protocol HomeViewPresenter: AnyObject {
    func startLoading()
    func stopLoading()
    func setData(_ data: APODData)
    func showAlert(title: String?, message: String?)
    func navigateToFullImage(builder: PhotoDetailBuilder)
}

final class HomeViewModel: HomeViewModelable {
    weak var presenter: HomeViewPresenter?
    private let dependency: HomeDependency
    private let dataInteractor: APODDataInteractorProtocol

    private var data: APODData?

    private let today: String = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: Date())
    }()

    init(dependency: HomeDependency, dataInteractor: APODDataInteractorProtocol) {
        self.dependency = dependency
        self.dataInteractor = dataInteractor
    }

    func fetchAPOD() {
        presenter?.startLoading()
        Task {
            do {
                self.data = try await dataInteractor.fetchAPOD(requestData: APODRequestModel(date: today))
                DispatchQueue.main.async {
                    self.presenter?.stopLoading()
                    self.presenter?.setData(self.data!)
                }
            } catch {
                switch error {
                case APODDataInteractorError.oldDataFound(let apodData):
                    self.data = apodData
                    DispatchQueue.main.async {
                        self.presenter?.stopLoading()
                        self.presenter?.setData(self.data!)
                        self.presenter?.showAlert(title: "No internet", message: "We are not connected to the internet, showing you the last image we have.")
                    }
                default:
                    DispatchQueue.main.async {
                        self.presenter?.stopLoading()
                        self.presenter?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }

    func showFullImage(image: UIImage?) {
        guard let img = image else { return }
        let detailBuilder = PhotoDetailBuilder(dependency: PhotoDetailDependency(image: img))
        presenter?.navigateToFullImage(builder: detailBuilder)
    }
}
