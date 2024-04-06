//
//  CalendarViewController.swift
//  EduRide
//
//  Created by Yash Agrawal on 4/5/24.
//

import UIKit

class CalendarViewController: UIViewController {
    var collectionView: UICollectionView!
    let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var dates: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        
        let calendar = Calendar.current
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in -5..<5 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
        
        collectionView.reloadData()
    }

    override func loadView() {
        // Create a ListCollectionViewLayout
        // Set the frame and layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        view = UIView(frame: UIScreen.main.bounds)
        view.addSubview(collectionView)
        
        // Set the collection view's frame to match the view controller's view bounds
        collectionView.frame = view.bounds
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.alwaysBounceHorizontal = true // Enable horizontal bouncing
        
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    // If the user clicks on a cell, display a message
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
  private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
      if section == 0 {
        // item
        let item = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/5),
            heightDimension: .fractionalHeight(1)
          )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                
        // group
        let groupSize = NSCollectionLayoutSize (
                      widthDimension: .fractionalWidth(1),
                      heightDimension: .estimated(140)
                  )
          
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 10)
                
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
        // return
        return section
                
      }
      return nil
    }
  }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // The number of cells is wholly dependent on the number of dates
        return dates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue the standard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        let date = dates[indexPath.item]
        let dayName = dayNames[Calendar.current.component(.weekday, from: date) - 1]
        let dayNumber = Calendar.current.component(.day, from: date)
        cell.dayNameLabel.text = dayName
        cell.dateLabel.text = "\(dayNumber)"
        return cell
    }
}

class DayCell: UICollectionViewCell {
    let dayNameLabel: UILabel = {
        let label = UILabel()
        // Configure the label properties
        label.text = "Day"
        label.backgroundColor = .systemRed
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        // Configure the label properties
        label.text = "Date"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up the cell's subviews and constraints
        contentView.addSubview(dayNameLabel)
        contentView.addSubview(dateLabel)
        
        // Add constraints for the labels
        dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dayNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dayNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
