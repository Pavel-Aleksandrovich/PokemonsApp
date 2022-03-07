//
//  ProgressCell.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 07.03.2022.
//

import UIKit

final class ProgressCell: UITableViewCell {
    
    private let activityView = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activityIsActivate() {
        activityView.startAnimating()
    }
    
    private func configureView() {
        [activityView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(activityView)
    }
    
   private func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
