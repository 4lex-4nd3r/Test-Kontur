//
//  SettingsViewController.swift
//  Test Kontur
//
//  Created by Александр on 29.08.2022.
//

protocol SettingChangedProtocol: AnyObject {
   
   func metricUpdated(metric: Metric)
}

import UIKit

class SettingsViewController : UIViewController {
   
   // MARK: - Properties
      
   private let settingsLabel: UILabel = {
      let label = UILabel()
      label.text = "Настройки"
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private lazy var closeButton: UIButton = {
      let button = UIButton()
      button.setTitle("Закрыть", for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
      return button
   }()
   
   var metric: Metric!
   
   private let heightLabel: UILabel = {
      let label = UILabel()
      label.text = "Высота"
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   private lazy var heightSegmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["m", "ft"])
      control.selectedSegmentIndex = 0
      control.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
      control.selectedSegmentTintColor = .white
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1)], for: .normal)
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)], for: .selected)
      control.addTarget(self, action: #selector(heightChanged), for: .valueChanged)
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
   }()

   private let diameterLabel: UILabel = {
      let label = UILabel()
      label.text = "Диаметр"
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   private lazy var diameterSegmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["m", "ft"])
      control.selectedSegmentIndex = 0
      control.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
      control.selectedSegmentTintColor = .white
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1)], for: .normal)
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)], for: .selected)
      control.addTarget(self, action: #selector(diameterChanged), for: .valueChanged)
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
   }()
   
   private let massLabel: UILabel = {
      let label = UILabel()
      label.text = "Масса"
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   private lazy var massSegmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["kg", "lb"])
      control.selectedSegmentIndex = 0
      control.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
      control.selectedSegmentTintColor = .white
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1)], for: .normal)
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)], for: .selected)
      control.addTarget(self, action: #selector(massChanged), for: .valueChanged)
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
   }()

   private let payloadLabel: UILabel = {
      let label = UILabel()
      label.text = "Полезная нагрузка"
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   private lazy var payloadSegmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["kg", "lb"])
      control.selectedSegmentIndex = 0
      control.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
      control.selectedSegmentTintColor = .white
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1)], for: .normal)
      control.setTitleTextAttributes([.foregroundColor : #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)], for: .selected)
      control.addTarget(self, action: #selector(payloadChanged), for: .valueChanged)
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
   }()
   
   private var labelsStackview = UIStackView()
   private var segsStackView = UIStackView()
   
   weak var delegate: SettingChangedProtocol?
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setConstraints()
      setupSelectors()
   }
   
   //MARK: - Setups
   
   private func setupViews() {
      view.backgroundColor = .black
      view.addSubview(settingsLabel)
      view.addSubview(closeButton)
      labelsStackview = UIStackView(arrangedSubviews: [heightLabel, diameterLabel, massLabel, payloadLabel], axis: .vertical, spacing: 45)
      segsStackView = UIStackView(arrangedSubviews: [heightSegmentedControl, diameterSegmentedControl, massSegmentedControl, payloadSegmentedControl], axis: .vertical, spacing: 24)
      view.addSubview(labelsStackview)
      view.addSubview(segsStackView)
   }
   
   private func setupSelectors() {
      heightSegmentedControl.selectedSegmentIndex = metric.isHeightMetric ? 0 : 1
      diameterSegmentedControl.selectedSegmentIndex = metric.isDiameterMetric ? 0 : 1
      massSegmentedControl.selectedSegmentIndex = metric.isMassKG ? 0 : 1
      payloadSegmentedControl.selectedSegmentIndex = metric.isPayloadKG ? 0 : 1
   }
   
   //MARK: - Selectors
   
   @objc private func closeButtonTapped() {
      dismiss(animated: true)
   }
   
   
   @objc private func heightChanged() {
      if heightSegmentedControl.selectedSegmentIndex == 0 {
         metric.isHeightMetric = true
         delegate?.metricUpdated(metric: metric)
      } else {
         metric.isHeightMetric = false
         delegate?.metricUpdated(metric: metric)
      }
   }
   
   @objc private func diameterChanged() {
      if diameterSegmentedControl.selectedSegmentIndex == 0 {
         metric.isDiameterMetric = true
         delegate?.metricUpdated(metric: metric)
      } else {
         metric.isDiameterMetric = false
         delegate?.metricUpdated(metric: metric)
      }
   }
   
   @objc private func massChanged() {
      if massSegmentedControl.selectedSegmentIndex == 0 {
         metric.isMassKG = true
         delegate?.metricUpdated(metric: metric)
      } else {
         metric.isMassKG = false
         delegate?.metricUpdated(metric: metric)
      }
   }
   
   @objc private func payloadChanged() {
      if payloadSegmentedControl.selectedSegmentIndex == 0 {
         metric.isPayloadKG = true
         delegate?.metricUpdated(metric: metric)
      } else {
         metric.isPayloadKG = false
         delegate?.metricUpdated(metric: metric)
      }
   }
   
   //MARK: - Constraints
   
   private func setConstraints() {
      NSLayoutConstraint.activate([
         settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
         settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
      
      NSLayoutConstraint.activate([
         closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
         closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
         closeButton.widthAnchor.constraint(equalToConstant: 75),
         closeButton.heightAnchor.constraint(equalToConstant: 22)
      ])
      
      NSLayoutConstraint.activate([
         labelsStackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
         labelsStackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
         labelsStackview.widthAnchor.constraint(equalToConstant: 160)
      ])
      
      NSLayoutConstraint.activate([
         segsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
         segsStackView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 72),
         segsStackView.widthAnchor.constraint(equalToConstant: 115)
      ])
      
      NSLayoutConstraint.activate([
         heightSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
         diameterSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
         massSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
         payloadSegmentedControl.heightAnchor.constraint(equalToConstant: 40)
      ])
   }
}
