//
//  ViewController.swift
//  Test Kontur
//
//  Created by Александр on 28.08.2022.
//

import UIKit

class MainViewController : UIViewController {
   
   // MARK: - Properties
   
   let shipManager = ShipsManager()
   
   private var ships = [Ship]()
   
   var isHeightMetric = true
   var isDiameterMetric = true
   var isMassKG = true
   var isPayloadKG = true
   
   private lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = .black
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
   }()
   
   private let contentView: UIView = {
      let contentView = UIView()
      contentView.translatesAutoresizingMaskIntoConstraints = false
      return contentView
   }()
   
   private let shipImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.image = UIImage(named: "back")
      imageView.contentMode = .scaleAspectFill
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   let blackView: UIView = {
      let view = UIView()
      view.layer.cornerRadius = 32
      view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      view.backgroundColor = .black
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()

   private let nameLabel: UILabel = {
      let label = UILabel()
      label.text = "Falcon Heavy"
      label.font = .systemFont(ofSize: 24, weight: .medium)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private lazy var settingsButton: UIButton = {
      let button = UIButton()
      button.setBackgroundImage(UIImage(named: "settings"), for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
      return button
   }()
   
   let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 12
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout )
      collectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
      collectionView.backgroundColor = .none
      collectionView.showsHorizontalScrollIndicator = false
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      return collectionView
   }()
   
   private let firstStageLabel: UILabel = {
      let label = UILabel()
      label.text = "ПЕРВАЯ СТУПЕНЬ"
      label.font = .systemFont(ofSize: 16, weight: .medium)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let secondStageLabel: UILabel = {
      let label = UILabel()
      label.text = "ВТОРАЯ СТУПЕНЬ"
      label.font = .systemFont(ofSize: 16, weight: .medium)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
  
   private let zeroStageView = ZeroStageView()
   private let firstStageView = StageView()
   private let secondStageView = StageView()

   private lazy var showLaunchesButton: UIButton = {
      let button = UIButton()
      button.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
      button.layer.cornerRadius = 12
      button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
      button.setTitle("Посмотреть запуски", for: .normal)
      button.addTarget(self, action: #selector(showLaunchesButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
   }()
   
   private lazy var pageControl: UIPageControl = {
      let pageControl = UIPageControl()
      pageControl.hidesForSinglePage = true
      pageControl.numberOfPages = 1
      pageControl.backgroundColor = #colorLiteral(red: 0.08947802335, green: 0.08947802335, blue: 0.08947802335, alpha: 1)
      pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
      pageControl.translatesAutoresizingMaskIntoConstraints = false
      return pageControl
   }()
   
   var properties: [(String, String)] = [
      ("Высота", ""),
      ("Диаметр", ""),
      ("Масса", ""),
      ("Нагрузка", "")
   ]
   
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setConstraints()
      shipManager.requestShips { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .success(let ships):
            self.ships = ships
            self.pageControl.numberOfPages = ships.count
            self.setupShipData(ship: ships[self.pageControl.currentPage])
         case .failure(let error):
            print(error)
         }
      }
   }
   
   //MARK: - Setups

   private func setupViews() {
      navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationController?.navigationBar.shadowImage = UIImage()
      navigationController?.navigationBar.isTranslucent = true
      navigationItem.backButtonTitle = "Назад"
      navigationController?.navigationBar.tintColor = .white
      view.backgroundColor = .white
      view.addSubview(scrollView)
      scrollView.addSubview(contentView)
      contentView.addSubview(shipImageView)
      contentView.addSubview(blackView)
      contentView.addSubview(nameLabel)
      contentView.addSubview(settingsButton)
      contentView.addSubview(collectionView)
      contentView.addSubview(zeroStageView)
      contentView.addSubview(firstStageLabel)
      contentView.addSubview(firstStageView)
      contentView.addSubview(secondStageLabel)
      contentView.addSubview(secondStageView)
      contentView.addSubview(showLaunchesButton)
      collectionView.register(PropertiesCollectionViewCell.self, forCellWithReuseIdentifier: PropertiesCollectionViewCell().idCell)
            collectionView.delegate = self
            collectionView.dataSource = self
      view.addSubview(pageControl)
   }
   
   private func setupShipData(ship: Ship) {
      
      nameLabel.text = ship.name
      setProperties(heigth: ship.height.meters,
                    diameter: ship.diameter.meters,
                    mass: ship.mass.kg,
                    payloadWeights: ship.payloadWeights[0].kg)
      setupZeroStage(firstFlight: ship.firstFlight,
                     country: ship.country,
                     costPerLaunch: ship.costPerLaunch)
      setupFirstStage(engines: ship.firstStage.engines,
                      fuelAmountTons: ship.firstStage.fuelAmountTons,
                      burnTimeSEC: ship.firstStage.burnTimeSEC)
      setupSecondStage(engines: ship.secondStage.engines,
                       fuelAmountTons: ship.secondStage.fuelAmountTons,
                       burnTimeSEC: ship.secondStage.burnTimeSEC)
   }
   
   private func setProperties(heigth: Double?, diameter: Double?, mass: Int, payloadWeights: Int ) {
      properties = [
         ("Высота", "\(heigth!)"),
         ("Диаметр", "\(diameter!)"),
         ("Масса", "\(mass)"),
         ("Нагрузка", "\(payloadWeights)")
      ]
      collectionView.reloadData()
   }
   
   private func setupZeroStage(firstFlight: String, country: String, costPerLaunch: Int) {
      zeroStageView.setData(firstFlight: firstFlight,
                            country: country,
                            costPerLaunch: costPerLaunch)
   }
   
   private func setupFirstStage(engines: Int, fuelAmountTons: Double, burnTimeSEC: Int?) {
      firstStageView.setData(engines: engines,
                             fuelAmountTons: fuelAmountTons,
                             burnTimeSEC: burnTimeSEC)
   }
   
   private func setupSecondStage(engines: Int, fuelAmountTons: Double, burnTimeSEC: Int?) {
      secondStageView.setData(engines: engines,
                              fuelAmountTons: fuelAmountTons,
                              burnTimeSEC: burnTimeSEC)
   }

   //MARK: - Selectors
   
   @objc private func settingsButtonTapped() {
      let settingsVC = SettingsViewController()
      settingsVC.modalPresentationStyle = .automatic
      present(settingsVC, animated: true)
   }
   
   @objc private func showLaunchesButtonTapped() {
      let launchesVC = LaunchesViewController()
      launchesVC.shipID = ships[pageControl.currentPage].id
      navigationController?.pushViewController(launchesVC, animated: true)
   }
   
   @objc private func pageControlValueChanged() {

      setupShipData(ship: ships[pageControl.currentPage])
   }
   
   //MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
         scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),
         scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
      
      NSLayoutConstraint.activate([
         contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
         contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
      ])
      
      NSLayoutConstraint.activate([
         shipImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
         shipImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         shipImageView.heightAnchor.constraint(equalToConstant: 400),
         shipImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
      ])

      NSLayoutConstraint.activate([
         blackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         blackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         blackView.topAnchor.constraint(equalTo: shipImageView.bottomAnchor, constant: -150),
         blackView.heightAnchor.constraint(equalToConstant: 920),
         blackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      ])
      
      NSLayoutConstraint.activate([
         nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
         nameLabel.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 48)
      ])
      
      NSLayoutConstraint.activate([
         settingsButton.widthAnchor.constraint(equalToConstant: 25),
         settingsButton.heightAnchor.constraint(equalToConstant: 25),
         settingsButton.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 50),
         settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35)
      ])
      
      NSLayoutConstraint.activate([
         collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         collectionView.heightAnchor.constraint(equalToConstant: 96),
         collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32)
      ])
      
      NSLayoutConstraint.activate([
         zeroStageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
         zeroStageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
         zeroStageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
         zeroStageView.heightAnchor.constraint(equalToConstant: 104)
      ])
      
      NSLayoutConstraint.activate([
         firstStageLabel.topAnchor.constraint(equalTo: zeroStageView.bottomAnchor, constant: 40),
         firstStageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
      ])
      
      NSLayoutConstraint.activate([
         firstStageView.topAnchor.constraint(equalTo: firstStageLabel.bottomAnchor, constant: 16),
         firstStageView.heightAnchor.constraint(equalToConstant: 104),
         firstStageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
         firstStageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
      ])
      
      NSLayoutConstraint.activate([
         secondStageLabel.topAnchor.constraint(equalTo: firstStageView.bottomAnchor, constant: 40),
         secondStageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
      ])
      
      NSLayoutConstraint.activate([
         secondStageView.topAnchor.constraint(equalTo: secondStageLabel.bottomAnchor, constant: 16),
         secondStageView.heightAnchor.constraint(equalToConstant: 104),
         secondStageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
         secondStageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
      ])
      
      NSLayoutConstraint.activate([
         showLaunchesButton.topAnchor.constraint(equalTo: secondStageView.bottomAnchor, constant: 40),
         showLaunchesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
         showLaunchesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
         showLaunchesButton.heightAnchor.constraint(equalToConstant: 56)
      ])
      
      NSLayoutConstraint.activate([
         pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         pageControl.heightAnchor.constraint(equalToConstant: 72)
      ])
   }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      4
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertiesCollectionViewCell().idCell, for: indexPath) as? PropertiesCollectionViewCell else {
         return UICollectionViewCell() }


      let name = properties[indexPath.row].0
      let amount = properties[indexPath.row].1

      cell.configure(name: name, amount: amount)
      return cell
   }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 96, height: 96)
   }
}




