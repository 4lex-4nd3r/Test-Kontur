//
//  LaunchesTableViewCell.swift
//  Test Kontur
//
//  Created by Александр on 29.08.2022.
//

import UIKit

class LaunchesTableViewCell : UITableViewCell {
   
   // MARK: - Properties
   
   let idCell = "Cell"
   
   private let backView: UIView = {
      let view = UIView()
      view.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
      view.layer.cornerRadius = 24
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   private let nameLabel: UILabel = {
      let label = UILabel()
      label.text = "Name Label"
      label.font = .systemFont(ofSize: 20, weight: .medium)
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let dateLabel: UILabel = {
      let label = UILabel()
      label.text = "Date Label"
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5607843137, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   
   private let statusImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.image = UIImage(systemName: "person")
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   // MARK: - Init
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupViews()
      setConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Setups
   
   private func setupViews() {
      backgroundColor = .clear
      selectionStyle = .none
      addSubview(backView)
      backView.addSubview(nameLabel)
      backView.addSubview(dateLabel)
      backView.addSubview(statusImageView)
   }
   

   func configure(launch: Launch) {
      nameLabel.text = launch.name
      
      let df = DateFormatter()
      df.dateFormat = "d MMMM, yyyy"
      let date = df.string(from: launch.dateUTC)
      dateLabel.text = date
      guard let success = launch.success else { return }
      statusImageView.image = UIImage(named: success ? "success" : "failure" )
   }
   
   // MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         backView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
         backView.bottomAnchor.constraint(equalTo: bottomAnchor),
         backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
         backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
      ])
      
      NSLayoutConstraint.activate([
         nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 24),
         nameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 24)
     ])
      
      NSLayoutConstraint.activate([
         dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
         dateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 24)
      ])
      
      NSLayoutConstraint.activate([
         statusImageView.widthAnchor.constraint(equalToConstant: 32),
         statusImageView.heightAnchor.constraint(equalToConstant: 32),
         statusImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -32),
         statusImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
      ])
   }
}
