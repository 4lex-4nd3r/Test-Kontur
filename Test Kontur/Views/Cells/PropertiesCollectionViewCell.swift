//
//  PropertiesCollectionViewCell.swift
//  Test Kontur
//
//  Created by Александр on 28.08.2022.
//



import UIKit

class PropertiesCollectionViewCell: UICollectionViewCell {

   //MARK: - Properties
   
   let idCell = "CollectionCell"
   
   private let dataLabel: UILabel = {
      let label = UILabel()
      label.text = "4273.00"
      label.font = .systemFont(ofSize: 16, weight: .heavy)
      label.textColor = .white
      label.textAlignment = .center
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let descriptionLabel: UILabel = {
      let label = UILabel()
      label.text = "Высота"
      label.font = .systemFont(ofSize: 14, weight: .medium)
      label.textColor = #colorLiteral(red: 0.6235294118, green: 0.6235294118, blue: 0.6274509804, alpha: 1)
      label.textAlignment = .center
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   //MARK: - Init
   
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
      backgroundColor = #colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)
      layer.cornerRadius = 32
      addSubview(dataLabel)
      addSubview(descriptionLabel)
   }
   
   func configure(name: String, amount: String) {
      descriptionLabel.text = name
      dataLabel.text = amount
   }
   
   //MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
         dataLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         dataLabel.widthAnchor.constraint(equalToConstant: 80),
         dataLabel.heightAnchor.constraint(equalToConstant: 24)
      ])
      
      NSLayoutConstraint.activate([
         descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
         descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         descriptionLabel.widthAnchor.constraint(equalToConstant: 80),
         descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
      ])
      
   }
}
