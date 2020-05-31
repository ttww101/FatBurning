//
//  WeightVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/8.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import Charts
//import Firebase

class WeightVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var WVstartMonthLabel: UILabel!
    @IBOutlet weak var WVcurrentMonthLabel: UILabel!
    @IBOutlet weak var WVexpectedWeightLabel: UILabel!
    @IBOutlet weak var WVweightSinceStartLabel: UILabel!
    @IBOutlet weak var WVweightSinceMonthLabel: UILabel!
    @IBOutlet weak var WVweightLossMonthLabel: UILabel!
    @IBOutlet weak var WVprogressView: UIProgressView!
    @IBOutlet weak var WVprogressLabel: UILabel!
    @IBOutlet weak var WVstatusImageView: UIImageView!
    @IBOutlet weak var WVstatusTitleLabel: UILabel!
    @IBOutlet weak var WVstatusTitleView: UIView!
    @IBOutlet weak var WVstatusCaptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var WVlevelCollectionView: UICollectionView!
    @IBOutlet weak var WVlineChartView: LineChartView!
    @IBOutlet weak var WVstarIcon: UIImageView!
    
    let userDefaults = UserDefaults.standard

    let weightProvider = WeightProvider()

    var WVweightDataArray = [WeightData]() {

        didSet {
//            tableView.reloadData()

            setChartValues()

            layoutStatus()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChartView()

        readWeight()

        WVlevelCollectionView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        layoutStatus()
    }

    private func readWeight() {

        weightProvider.getWeight { (result) in

            switch result {

            case .success(let weightDataArray):

                self.WVweightDataArray = weightDataArray

                print("==============")
                print(weightDataArray)

            case .failure(let error):

                print(error)
            }
        }
    }

    @IBAction func recordWeightPressed(_ sender: UIButton) {

        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)

        let desVC = profileStoryboard.instantiateViewController(withIdentifier: "RecordWeightVC")

        guard let recordWeightVC = desVC as? RecordWeightVC else { return }

        recordWeightVC.RWweightDocumentID = nil

        recordWeightVC.reloadDataAfterUpdate = { [weak self] in

            self?.WVweightDataArray = [WeightData]()

            self?.readWeight()

//            self?.tableView.reloadData()
        }

        present(recordWeightVC, animated: true)
    }

    private func layoutStatus() {

        weightProvider.getStatus { [weak self] (status) in

            guard let strongSelf = self else { return }

            let weightSinceStart = status.weightSinceStart

            let weightSinceMonth = status.weightSinceMonth

            if weightSinceStart > 0 {
                strongSelf.WVweightSinceStartLabel.text = "+\(weightSinceStart.format(f: ".1"))"
            } else {
                strongSelf.WVweightSinceStartLabel.text = weightSinceStart.format(f: ".1")
            }

            let percentage = Int(Float((0 - weightSinceMonth) / 1) * 100)

            if weightSinceMonth > 0 {
                strongSelf.WVweightSinceMonthLabel.text = "+\(weightSinceMonth.format(f: ".1"))"
                strongSelf.WVprogressView.progress = 0
                strongSelf.WVprogressLabel.text = "0%"
                strongSelf.WVstarIcon.isHidden = true
            } else if percentage >= 100 {
                strongSelf.WVweightSinceMonthLabel.text = weightSinceMonth.format(f: ".1")
                strongSelf.WVprogressView.progress = Float((0 - weightSinceMonth) / 1)
                strongSelf.WVprogressLabel.text = "\(Int(Float((0 - weightSinceMonth) / 1) * 100))%"
                strongSelf.WVstarIcon.isHidden = false
            } else {
                strongSelf.WVweightSinceMonthLabel.text = weightSinceMonth.format(f: ".1")
                strongSelf.WVprogressView.progress = Float((0 - weightSinceMonth) / 1)
                strongSelf.WVprogressLabel.text = "\(Int(Float((0 - weightSinceMonth) / 1) * 100))%"
                strongSelf.WVstarIcon.isHidden = true
            }

            strongSelf.WVstartMonthLabel.text = status.signupTime

            strongSelf.WVcurrentMonthLabel.text = DateFormatter.chineseYearMonth(date: Date())

            strongSelf.WVexpectedWeightLabel.text = String(status.expectWeight)
        }

    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        // Cloud Firestore
//        guard let uid = userDefaults.value(forKey: "uid") as? String else { return }
//
////        let weightRef = AppDelegate.db.collection("users").document(uid).collection("weight")
//
//        let documentID = self.WVweightDataArray[indexPath.row].documentID
//
//        // Action sheet setup
//        let optionMenu = UIAlertController(title: "编辑体重资料", message: nil, preferredStyle: .actionSheet)
//
//        let editAction = UIAlertAction(title: "修改体重", style: .default) { [weak self] (_) in
//
//            let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
//            let desVC = profileStoryboard.instantiateViewController(withIdentifier: "RecordWeightVC")
//            guard let recordWeightVC = desVC as? RecordWeightVC else { return }
//            recordWeightVC.weightDocumentID = documentID
//
//            recordWeightVC.reloadDataAfterUpdate = { [weak self] in
//
//                guard let strongSelf = self else { return }
//
//                strongSelf.WVweightDataArray = [WeightData]()
//
//                strongSelf.readWeight()
//            }
//
//            self?.present(recordWeightVC, animated: true)
//        }
//
//        let deleteAction = UIAlertAction(title: "删除", style: .destructive) { [weak self] (_) in
//
//            // Delete document
//            guard let documentID = documentID else { return }
//
////            weightRef.document(documentID).delete(completion: { (error) in
////                if let error = error {
////                    print("Error deleting document: \(error)")
////                } else {
////                    print("Document succesfully deleted")
////                }
////            })
//
//            self?.WVweightDataArray = [WeightData]()
//
//            self?.readWeight()
//
//            self?.tableView.reloadData()
//
//            self?.setChartValues()
//        }
//
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
//            optionMenu.dismiss(animated: true, completion: nil)
//        }
//
//        optionMenu.addAction(editAction)
//        optionMenu.addAction(deleteAction)
//        optionMenu.addAction(cancelAction)
//
//        self.present(optionMenu, animated: true, completion: nil)
//
//    }

    private func setChartValues() {

        var referenceTimeInterval: TimeInterval = 0
        if let minTimeInterval = (WVweightDataArray.map({ $0.createdTime!.millisecondsSince1970})).min() {
            referenceTimeInterval = TimeInterval(minTimeInterval)
        }

        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
        formatter.dateFormat = "M月d日"
        formatter.locale = Locale.current

        let xValuesNumberFormatter = ChartsDateXAxisFormatter(
            referenceTimeInterval: referenceTimeInterval,
            dateFormatter: formatter)

        let reverseArray = WVweightDataArray.reversed() // 時間排序由舊到新

        var entries = [ChartDataEntry]()
        for weightData in reverseArray {
            let timeInterval = weightData.createdTime!.timeIntervalSince1970
            let xValue = (timeInterval - referenceTimeInterval) / (3600 * 24)

            let yValue = weightData.weight
            let entry = ChartDataEntry(x: xValue, y: yValue)
            entries.append(entry)
        }

        WVlineChartView.xAxis.valueFormatter = xValuesNumberFormatter

        let lineDataSet = LineChartDataSet(entries: entries, label: "Weight Chart")
        lineDataSet.circleRadius = 2.5
        lineDataSet.circleColors = [UIColor.B1!]
        lineDataSet.circleHoleRadius = 0
        lineDataSet.lineWidth = 2
        lineDataSet.colors = [UIColor.Orange!]
        lineDataSet.drawValuesEnabled = false // hide y-values

        let gradient = getGradientFilling()
        lineDataSet.fillAlpha = 0.7
        lineDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        lineDataSet.drawFilledEnabled = true
        let data = LineChartData(dataSet: lineDataSet)
        self.WVlineChartView.data = data

    }

    private func getGradientFilling() -> CGGradient {

        let colorTop = UIColor(red: 230/255, green: 247/255, blue: 255/255, alpha: 1).cgColor
        let colorBottom = UIColor.Orange!.cgColor
//        let colorTop = UIColor.hexStringToUIColor(hex: "F77A25").cgColor
//        let colorBottom = UIColor.hexStringToUIColor(hex: "FCB24C").cgColor

        let gradientColors = [colorTop, colorBottom] as CFArray

        let colorLocations: [CGFloat] = [0.7, 0.0]

        return CGGradient.init(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: gradientColors,
            locations: colorLocations)!
    }

    private func setupChartView() {

        // Remove horizonatal line, right value label, legend below chart
        self.WVlineChartView.xAxis.drawGridLinesEnabled = false
        self.WVlineChartView.leftAxis.axisLineColor = UIColor.clear
        self.WVlineChartView.rightAxis.drawLabelsEnabled = false
        self.WVlineChartView.rightAxis.enabled = false
        self.WVlineChartView.legend.enabled = false
        self.WVlineChartView.xAxis.axisLineColor = .clear

        // Change xAxis label from top to bottom
        WVlineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        WVlineChartView.minOffset = 0
    }

}

extension WeightVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = WVlevelCollectionView.dequeueReusableCell(
            withReuseIdentifier: "LevelCollectinoViewCell",
            for: indexPath)

        let levelColors: [UIColor] = [
            .hexStringToUIColor(hex: "A5DB7F"),
            .hexStringToUIColor(hex: "FADA5B"),
            .hexStringToUIColor(hex: "F9BC51"),
            .hexStringToUIColor(hex: "F99243"),
            .hexStringToUIColor(hex: "F96936"),
            .hexStringToUIColor(hex: "F73625")
        ]

        cell.backgroundColor = levelColors[indexPath.item]

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        let levelCollectionViewWidth = WVlevelCollectionView.bounds.width
        return CGSize(width: levelCollectionViewWidth / 6, height: 16)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 0
    }

}

//extension WeightVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView,
//                   numberOfRowsInSection section: Int) -> Int {
//        return WVweightDataArray.count
//    }
//
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeightEntryTableViewCell", for: indexPath)
//        guard let weightCell = cell as? WeightEntryTableViewCell else { return cell }
//
//        let weightData = weightDataArray[indexPath.row]
//
//        weightCell.layoutView(date: weightData.createdTimeString, weight: weightData.weight)
//
//        return cell
//    }
//
//}
