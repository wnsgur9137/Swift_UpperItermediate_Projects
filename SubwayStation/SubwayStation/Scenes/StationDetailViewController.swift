//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by 이준혁 on 2022/10/05.
//

import UIKit
import SnapKit
import Alamofire

final class StationDetailViewController: UIViewController {
    private let station: Station
    private var realTimeArrivalList: [StationArrivalDatResponseModel.RealTimeArrival] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StationDetailCollectionViewCell.self, forCellWithReuseIdentifier: "StationDetailCollectionViewCell")
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    init(station: Station) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = station.stationName
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fetchData()
    }
    
    @objc private func fetchData() {
//        refreshControl.endRefreshing()
        
        let stationName = station.stationName
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/xml/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))"
        
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDatResponseModel.self) { [weak self] response in
                self?.refreshControl.endRefreshing()
                guard case .success(let data) = response.result else { return }
                
                self?.realTimeArrivalList = data.realtimeArrivalList
                self?.collectionView.reloadData()
            }
            .resume()
    }
}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realTimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationDetailCollectionViewCell", for: indexPath) as? StationDetailCollectionViewCell
        
        let realTimeArrival = realTimeArrivalList[indexPath.row]
        cell?.setup(with: realTimeArrival)
        
        return cell ?? UICollectionViewCell()
    }
}
