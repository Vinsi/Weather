//
//  ViewController.swift
//  Weather
//
//  Created by Vinsi on 29/04/2021.
//

import UIKit
import RxSwift
import Kingfisher

extension UITableViewCell {
    static var name: String {
        String(describing: Self.self)
    }
}

final class LandingViewController: UIViewController, StoryBoarded {
    let viewModel = LandingViewModel()
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.load()
        viewModel.title.asObserver().subscribe { [weak self] event in
            if case .next(let value) = event {
                self?.title = value
            }
        }.disposed(by: disposeBag)
        
        viewModel.list.asObserver().subscribe { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
}

extension LandingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerCells() {
        let weatherCell = UINib(nibName: WeatherCell.name, bundle: nil)
        tableView.register(weatherCell, forCellReuseIdentifier: WeatherCell.name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = (try? viewModel.list.value().count) ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  WeatherCell.name, for: indexPath)as! WeatherCell
        if let item = try? viewModel.list.value()[indexPath.row] {
            cell.configure(type: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

final class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func configure(type: LandingViewTypeModel) {
        iconImageView.kf.setImage(with: URL(string: type.iconURL))
        dateTimeLabel.text = type.date
        descriptionLabel.text = type.description
        windSpeedLabel.text = "\(type.windSpeed)"
        temperatureLabel.text = "\(type.temperature).Celsius"
    }
}

final class SearchCell: UITableViewCell {
    
    @IBOutlet private(set) weak var cityLabel: UILabel!
}
