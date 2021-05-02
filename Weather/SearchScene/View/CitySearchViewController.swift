//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Vinsi on 03/05/2021.
//
import UIKit
import Foundation
import RxSwift
final class CitySearchViewController: UIViewController {
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let disposebag = DisposeBag()
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCities()
        viewModel.filterdCities.subscribe { [weak self] event in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.disposed(by: disposebag)
    }
    
    func onTextChange(text: String) {
        viewModel.keyword.onNext(text)
    }
    
    
}
extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerCells() {
        let weatherCell = UINib(nibName: WeatherCell.name, bundle: nil)
        tableView.register(weatherCell, forCellReuseIdentifier: WeatherCell.name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = (try? viewModel.filterdCities..count) ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  WeatherCell.name, for: indexPath)as! WeatherCell
        if let item = try? viewModel.keyword.value()?[indexPath.row] {
            //cell.configure(type: )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
