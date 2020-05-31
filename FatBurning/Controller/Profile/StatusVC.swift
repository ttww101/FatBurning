//
//  StatusVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/8.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import Charts

// swiftlint:disable identifier_name
class StatusVC: UIViewController, UITableViewDelegate, ChartViewDelegate {
    
    @IBOutlet weak var SVweekStartEndLabel: UILabel!
    
    @IBOutlet weak var SVchartView: BarChartView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var SVnextWeekBtn: UIButton!
    
    @IBOutlet weak var SVpreviousWeekBtn: UIButton!
    
    let statusProvider = StatusProvider()
    
    var weeksBeforeCount = 0 {
        didSet {
            if weeksBeforeCount == 0 {
                SVnextWeekBtn.isHidden = true
            } else {
                SVnextWeekBtn.isHidden = false
            }
        }
    }
    
    @IBAction func nextWeekBtnPressed(_ sender: UIButton) {
        statusProvider.reset()
        weeksBeforeCount += 1
        getWeeklyWorkoutData(weeksBefore: weeksBeforeCount)
        presentWeekLabel(weeksBeforeCount: weeksBeforeCount)
    }
    
    @IBAction func previousWeekBtnPressed(_ sender: UIButton) {
        statusProvider.reset()
        weeksBeforeCount -= 1
        getWeeklyWorkoutData(weeksBefore: weeksBeforeCount)
        presentWeekLabel(weeksBeforeCount: weeksBeforeCount)
    }
    
    func presentWeekLabel(weeksBeforeCount: Int) {
        let today = Date()
        guard let referenceDay = Calendar.current.date(
            byAdding: .day,
            value: 0 + 7 * weeksBeforeCount,
            to: today) else { return }
        let monday = referenceDay.dayOf(.monday)
        let sunday = referenceDay.dayOf(.sunday)
        
        if weeksBeforeCount == 0 {
            SVweekStartEndLabel.text = "本周记录"
        } else {
            let mondayOfWeek = DateFormatter.chineseMonthDate(date: monday)
            let sundayOfWeek = DateFormatter.chineseMonthDate(date: sunday)
            SVweekStartEndLabel.text = "\(mondayOfWeek)至\(sundayOfWeek)"
        }
        
    }
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    var SVworkoutDataArray = [WorkoutData]()

    var trainTimeSum: Int?

    var stretchTimeSum: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var SVactivityEntryArray = [ActivityEntry]() {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getWeeklyWorkoutData(weeksBefore: 0)
        
        SVweekStartEndLabel.text = "本周记录"
        
        SVnextWeekBtn.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVworkoutDataArray = [WorkoutData]()
    }
    
    private func getWeeklyWorkoutData(weeksBefore: Int) {
        
        statusProvider.getWeeklyWorkout(weeksBefore: weeksBefore) { (result) in
            
            switch result {
                
            case .success(let result):
                
                self.setupActivityEntry()

                self.setChartData(count: 7, range: 60)

                self.barChartViewSetup()
                
                print(result)
                
            case .failure(let error):
                
                print(error)
                
            }
        }
        
    }
    
    private func setupActivityEntry() {

        // sort for tableView data display
        let train0 = ActivityEntry(
            title: TrainItem.train0.title,
            time: statusProvider.train0Sum,
            activityType: ActivityType.train.rawValue)

        let train1 = ActivityEntry(
            title: TrainItem.train1.title,
            time: statusProvider.train1Sum,
            activityType: ActivityType.train.rawValue)

        let train2 = ActivityEntry(
            title: TrainItem.train2.title,
            time: statusProvider.train2Sum,
            activityType: ActivityType.train.rawValue)

        let train3 = ActivityEntry(
            title: TrainItem.train3.title,
            time: statusProvider.train3Sum,
            activityType: ActivityType.train.rawValue)

        let train4 = ActivityEntry(
            title: TrainItem.train4.title,
            time: statusProvider.train4Sum,
            activityType: ActivityType.train.rawValue)
        
        let train5 = ActivityEntry(
            title: TrainItem.train5.title,
            time: statusProvider.train5Sum,
            activityType: ActivityType.train.rawValue)

        let stretch0 = ActivityEntry(
            title: StretchItem.stretch0.title,
            time: statusProvider.stretch0Sum,
            activityType: ActivityType.stretch.rawValue)

        let stretch1 = ActivityEntry(
            title: StretchItem.stretch1.title,
            time: statusProvider.stretch1Sum,
            activityType: ActivityType.stretch.rawValue)

        let stretch2 = ActivityEntry(
            title: StretchItem.stretch2.title,
            time: statusProvider.stretch2Sum,
            activityType: ActivityType.stretch.rawValue)
        
        let stretch3 = ActivityEntry(
            title: StretchItem.stretch3.title,
            time: statusProvider.stretch3Sum,
            activityType: ActivityType.stretch.rawValue)

        let tempEntryArray = [train0, train1, train2, train3, train4, train5, stretch0, stretch1, stretch2, stretch3]

        SVactivityEntryArray = tempEntryArray.filter({$0.time != 0})

        SVactivityEntryArray = SVactivityEntryArray.sorted(by: { $0.time > $1.time })

    }
    
    private func barChartViewSetup() {
        
        SVchartView.animate(yAxisDuration: 0.5)
        
        // toggle YValue
        for set in SVchartView.data!.dataSets {
            set.drawValuesEnabled = false
        }
        
        // disable highlight
        SVchartView.data!.highlightEnabled = false
        
        // Toggle Icon
//        for set in chartView.data!.dataSets {
//            set.drawIconsEnabled = !set.drawIconsEnabled
//        }
        
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
    
    private func setChartData(count: Int, range: UInt32) {
        
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in

            let dailyTrain = statusProvider.weekSum[i][0]
            let dailyStretch = statusProvider.weekSum[i][1]

            return BarChartDataEntry(x: Double(i), yValues: [Double(dailyTrain), Double(dailyStretch)], icon: #imageLiteral(resourceName: "Icon_Profile_Star"))
        }
        
        let set = BarChartDataSet(entries: yVals, label: "Weekly Status")
        set.drawIconsEnabled = false
        set.colors = [
            NSUIColor(cgColor: UIColor(red: 247/255, green: 122/255, blue: 37/255, alpha: 1).cgColor),
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

extension StatusVC: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return week[Int(value) % week.count]
        
    }
}

extension StatusVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0: return 1
            
        default: return SVactivityEntryArray.count
            
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PieChartTableViewCell", for: indexPath)
            
            guard let pieChartCell = cell as? PieChartTableViewCell else { return cell }
            
            pieChartCell.layoutView(trainSum: statusProvider.trainTimeSum, stretchSum: statusProvider.stretchTimeSum)
            
            return pieChartCell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityEntryTableViewCell", for: indexPath)
            
            guard let entryCell = cell as? ActivityEntryTableViewCell else { return cell }
            
            let activityEntry = SVactivityEntryArray[indexPath.row]
             
            entryCell.layoutView(
                title: activityEntry.title,
                time: activityEntry.time,
                percentage: statusProvider.percentageOf(entry: activityEntry.time),
                activityType: activityEntry.activityType)
            
            return entryCell
            
        }
        
    }

}
