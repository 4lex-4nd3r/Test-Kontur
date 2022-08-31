//
//  FirstStageView.swift
//  Test Kontur
//
//  Created by Александр on 28.08.2022.
//

import UIKit

class StageView : UIView {
   
   // MARK: - Properties
   
   private let enginesLabel: UILabel = {
      let label = UILabel()
      label.text = "Количество двигателей"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let enginesCountLabel: UILabel = {
      let label = UILabel()
      label.text = ""
      label.font = .systemFont(ofSize: 16, weight: .bold)
      label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let fuelLabel: UILabel = {
      let label = UILabel()
      label.text = "Количество топлива"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let fuelCountLabel: UILabel = {
      let label = UILabel()
      label.text = ""
      label.font = .systemFont(ofSize: 16, weight: .bold)
      label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   
   
   private let timeLabel: UILabel = {
      let label = UILabel()
      label.text = "Время сгорания"
      label.font = .systemFont(ofSize: 16)
      label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let timeInSecLabel: UILabel = {
      let label = UILabel()
      label.text = ""
      label.font = .systemFont(ofSize: 16, weight: .bold)
      label.textColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let extraLabel1: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let extraLabel2: UILabel = {
      let label = UILabel()
      label.text = "ton"
      label.font = .systemFont(ofSize: 16, weight: .bold)
      label.textColor = #colorLiteral(red: 0.6250903606, green: 0.6252030134, blue: 0.6286859512, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let extraLabel3: UILabel = {
      let label = UILabel()
      label.text = "sec"
      label.font = .systemFont(ofSize: 16, weight: .bold)
      label.textColor = #colorLiteral(red: 0.6250903606, green: 0.6252030134, blue: 0.6286859512, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private var enginesStackView = UIStackView()
   private var subEnginesStackView = UIStackView()
   private var fuelStackView = UIStackView()
   private var subFuelStackView = UIStackView()
   private var timeStackView = UIStackView()
   private var subTimeStackVieww = UIStackView()
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
      subEnginesStackView = UIStackView(arrangedSubviews: [enginesCountLabel, extraLabel1], axis: .horizontal, spacing: 8)
      enginesStackView = UIStackView(arrangedSubviews: [enginesLabel, subEnginesStackView], axis: .horizontal, spacing: 8)
      subFuelStackView = UIStackView(arrangedSubviews: [fuelCountLabel, extraLabel2], axis: .horizontal, spacing: 8)
      fuelStackView = UIStackView(arrangedSubviews: [fuelLabel, subFuelStackView], axis: .horizontal, spacing: 8)
      subTimeStackVieww = UIStackView(arrangedSubviews: [timeInSecLabel, extraLabel3], axis: .horizontal, spacing: 8)
      timeStackView = UIStackView(arrangedSubviews: [timeLabel, subTimeStackVieww], axis: .horizontal, spacing: 8)
      
      allStackView = UIStackView(arrangedSubviews: [enginesStackView, fuelStackView, timeStackView], axis: .vertical, spacing: 16)

      addSubview(allStackView)

   }
   
   func setData(engines: Int, fuelAmountTons: Double, burnTimeSEC: Int?) {
      enginesCountLabel.text = "\(engines)"
      fuelCountLabel.text = "\(fuelAmountTons)"
      timeInSecLabel.text = "\(burnTimeSEC ?? 0)"
   }
   
   private func setConstraints() {
      NSLayoutConstraint.activate([
         allStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
         allStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
         allStackView.topAnchor.constraint(equalTo: topAnchor)
      ])

      NSLayoutConstraint.activate([
         extraLabel1.widthAnchor.constraint(equalToConstant: 28),
         extraLabel2.widthAnchor.constraint(equalToConstant: 28),
         extraLabel3.widthAnchor.constraint(equalToConstant: 28),
      ])
   }
   
}
