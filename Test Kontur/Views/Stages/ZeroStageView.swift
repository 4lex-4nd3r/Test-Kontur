//
//  ZeroStageView.swift
//  Test Kontur
//
//  Created by Александр on 28.08.2022.
//

import UIKit

class ZeroStageView : UIView {
   
   // MARK: - Properties
   
   private let launchLabel: UILabel = {
      let label = UILabel()
      label.text = "Первый запуск"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let launchDateLabel: UILabel = {
      let label = UILabel()
      label.text = "7 февраля, 2018"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var launchStackView = UIStackView()
   
   
   private let countryLabel: UILabel = {
      let label = UILabel()
      label.text = "Страна"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let countryNameLabel: UILabel = {
      let label = UILabel()
      label.text = "США"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var countryStackView = UIStackView()

   private let costLabel: UILabel = {
      let label = UILabel()
      label.text = "Стоимость запуска"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let costPriceLabel: UILabel = {
      let label = UILabel()
      label.text = "$90 млн"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var costStackView = UIStackView()

   private var allStackView = UIStackView()
   
   
   
   // MARK: - Init
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Setups
   
   private func setupViews() {
      translatesAutoresizingMaskIntoConstraints = false
      launchStackView = UIStackView(arrangedSubviews: [launchLabel, launchDateLabel], axis: .horizontal, spacing: 10)
      countryStackView = UIStackView(arrangedSubviews: [countryLabel, countryNameLabel], axis: .horizontal, spacing: 10)
      costStackView = UIStackView(arrangedSubviews: [costLabel, costPriceLabel], axis: .horizontal, spacing: 10)
      
      allStackView = UIStackView(arrangedSubviews: [launchStackView, countryStackView, costStackView], axis: .vertical, spacing: 16)
      addSubview(allStackView)
      allStackView.frame = frame
   }
   
   func setData(firstFlight: String, country: String, costPerLaunch: Int) {
      launchDateLabel.text = firstFlight
      countryNameLabel.text = country
      costPriceLabel.text = "\(costPerLaunch)"
   }
   
   private func setConstraints() {
      NSLayoutConstraint.activate([
         allStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
         allStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
         allStackView.topAnchor.constraint(equalTo: topAnchor)
      ])
   }
   
}

