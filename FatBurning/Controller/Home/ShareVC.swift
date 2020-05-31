//
//  ShareVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/14.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import Charts
import MBCircularProgressBar

class ShareVC: UIViewController, ChartViewDelegate {
    
//    @IBOutlet weak var todayStatusBtn: UIButton!
//
//    @IBOutlet weak var weeklyStatusBtn: UIButton!
//
//    @IBOutlet var statusBtns: [UIButton]!
    
    @IBOutlet weak var SVtodayStatusView: UIView!
    
    @IBOutlet weak var SVweeklyStatusView: UIView!
    
    // today status
    @IBOutlet weak var SVweekProgressCollectionView: UICollectionView!
    
    @IBOutlet weak var SVtrainProgressView: MBCircularProgressBarView!
    
    @IBOutlet weak var SVstretchProgressView: MBCircularProgressBarView!
    
    @IBOutlet weak var SVchartView: BarChartView!
    
    @IBOutlet weak var SVstretchTimeLabel: UILabel!
    
    @IBOutlet weak var SVtrainTimeLabel: UILabel!
    
    @IBOutlet weak var SVtodayTotalTimeLabel: UILabel!
    
    @IBOutlet weak var SVtodayDateLabel: UILabel!

    var SVselectedImageIndex = 0
    
    var SVdailyValue = [Int]()
    
//    @IBAction func selectStatusBtnPressed(_ sender: UIButton) {
//
//        for btn in statusBtns {
//
//            btn.isSelected = false
//
//        }
//
//        sender.isSelected = true
//
//        selectStatus(withTag: sender.tag)
//
//    }
    
    func selectStatus(withTag tag: Int) {
        
        if tag == 0 {
            SVtodayStatusView.isHidden = false
            SVweeklyStatusView.isHidden = true
            
            SVselectedImageIndex = tag
            
        } else {
            SVtodayStatusView.isHidden = true
            SVweeklyStatusView.isHidden = false
            
            SVselectedImageIndex = tag
            
        }
        
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        
        let renderer = UIGraphicsImageRenderer(size: SVtodayStatusView.bounds.size)
        
        let renderedTodayStatus = renderer.image { (_) in
            SVtodayStatusView.drawHierarchy(in: SVtodayStatusView.bounds, afterScreenUpdates: true)
        }
        
        let renderedWeeklyStatus = renderer.image { (_) in
            SVweeklyStatusView.drawHierarchy(in: SVweeklyStatusView.bounds, afterScreenUpdates: true)
        }
        
        // image to share
        let renderedImageArray = [ renderedTodayStatus, renderedWeeklyStatus ]
        
        let image = renderedImageArray[SVselectedImageIndex]
        
        // set up activity view controller
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [
//        UIActivity.ActivityType.airDrop,
//        UIActivity.ActivityType.postToFacebook
//        ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // Properties of BarChart
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    let week = ["ㄧ", "二", "三", "四", "五", "六", "日"]
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " $"
        formatter.positiveSuffix = " $"
        
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        SVchartView.delegate = self
        
        axisFormatDelegate = self
        
        barChartUpdate()
        barChartViewSetup()
        
    }
    
    func barChartViewSetup() {
        
        // toggle YValue
        for set in SVchartView.data!.dataSets {
            set.drawValuesEnabled = !set.drawValuesEnabled
        }
        //        chartView.setNeedsDisplay()
        
        // disable highlight
        SVchartView.data!.highlightEnabled = false
        
        // Toggle Icon
        for set in SVchartView.data!.dataSets {
            set.drawIconsEnabled = !set.drawIconsEnabled
        }
        SVchartView.setNeedsDisplay()
        
        // Remove horizonatal line, right value label, legend below chart
        self.SVchartView.xAxis.drawGridLinesEnabled = false
        self.SVchartView.leftAxis.axisLineColor = UIColor.clear
        self.SVchartView.rightAxis.drawLabelsEnabled = false
        self.SVchartView.rightAxis.enabled = false
        self.SVchartView.legend.enabled = false
        
        // Change xAxis label from top to bottom
        SVchartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        SVchartView.minOffset = 0
        
    }
    
    func barChartUpdate () {
        
        // Basic set up of plan chart
        
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(50))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(20))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(30))
        let entry4 = BarChartDataEntry(x: 3.0, y: Double(40))
        let entry5 = BarChartDataEntry(x: 3.0, y: Double(30))
        let entry6 = BarChartDataEntry(x: 3.0, y: Double(40))
        let entry7 = BarChartDataEntry(x: 3.0, y: Double(30))
        
        let dataSet = BarChartDataSet(
            entries: [entry1, entry2, entry3, entry4, entry5, entry6, entry7],
            label: "Weekly Status")
        let data = BarChartData(dataSets: [dataSet])
        SVchartView.data = data
        SVchartView.chartDescription?.text = ""
        
        // Color
        dataSet.colors = ChartColorTemplates.vordiplom()
        
        // Refresh chart with new data
        SVchartView.notifyDataSetChanged()
        
        setChartData(count: 7, range: 60)
    }
    
    // swiftlint:disable identifier_name
    func setChartData(count: Int, range: UInt32) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val1 = Double(arc4random_uniform(mult) + mult / 2)
            let val2 = Double(arc4random_uniform(mult) + mult / 2)
            
            return BarChartDataEntry(x: Double(i), yValues: [val1, val2], icon: #imageLiteral(resourceName: "Icon_Profile_Star"))
        }
        
        let set = BarChartDataSet(entries: yVals, label: "Weekly Status")
        set.drawIconsEnabled = false
        set.colors = [
            NSUIColor(cgColor: UIColor.Orange!.cgColor),
            NSUIColor(cgColor: UIColor.G1!.cgColor)
        ]
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueTextColor(.white)
        data.barWidth = 0.4
        
        SVchartView.fitBars = true
        SVchartView.data = data
        
        // Add string to xAxis
        let xAxisValue = SVchartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
    }

}

extension ShareVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
        ) -> Int {
        
        return 7
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            
            let days = ["ㄧ", "二", "三", "四", "五", "六", "日"]
            
            let cell = SVweekProgressCollectionView.dequeueReusableCell(
                withReuseIdentifier: "WeekProgressCollectionViewCell", for: indexPath)
            
            guard let progressCell = cell as? WeekProgressCollectionViewCell else { return cell }
            
            progressCell.dayLabel.text = days[indexPath.item]
        
            progressCell.layoutView(value: self.SVdailyValue[indexPath.item])
            
            return progressCell
        
    }
    
}

extension ShareVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: 20, height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
            return 21
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

extension ShareVC: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return week[Int(value) % week.count]
    }
    
}
