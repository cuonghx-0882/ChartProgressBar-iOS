//
//  MainViewController.swift
//  ChartProgressBar-ios
//
//  Created by Hadi Dbouk on 1/24/18.
//  Copyright © 2018 Hadi Dbouk. All rights reserved.
//

import ChartProgressBar

class MainViewController: UIViewController {

    @IBOutlet var chart: ChartProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var data: [BarData] = []
        
        data.append(BarData.init(barTitle: "Jan", barValue: 1.4, pinText: "1.4 €"))
        data.append(BarData.init(barTitle: "Feb", barValue: 10, pinText: "10 €"))
        data.append(BarData.init(barTitle: "Mar", barValue: 3.1, pinText: "3.1 €"))
        data.append(BarData.init(barTitle: "Apr", barValue: 4.8, pinText: "4.8 €"))
        data.append(BarData.init(barTitle: "May", barValue: 6.6, pinText: "6.6 €"))
        data.append(BarData.init(barTitle: "Jun", barValue: 7.4, pinText: "7.4 €"))
        data.append(BarData.init(barTitle: "Jul", barValue: 5.5, pinText: "5.5 €"))
        
        chart.data = data
        chart.barsCanBeClick = true
        chart.maxValue = 10.0
        chart.emptyColor = UIColor.clear
        chart.barWidth = 7
        chart.progressColor = UIColor.init(hexString: "99ffffff")
        chart.progressClickColor = UIColor.init(hexString: "F2912C")
        chart.pinBackgroundColor = UIColor.init(hexString: "E2335E")
        chart.pinTxtColor = UIColor.init(hexString: "ffffff")
        chart.barTitleColor = UIColor.init(hexString: "B6BDD5")
        chart.barTitleSelectedColor = UIColor.init(hexString: "FFFFFF")
        chart.pinMarginBottom = 15
        chart.pinWidth = 70
        chart.pinHeight = 29
        chart.pinTxtSize = 17
        chart.delegate = self
        chart.build()
        chart.disableBar(at: 3)
        let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chart.enableBar(at: 3)
        }
    }
    
    @IBAction func removeValues(_ sender: Any) {
        chart.removeValues()
    }
    
    @IBAction func isBarsEmpty(_ sender: Any) {
        let alert = UIAlertController(title: "Is bars Empty ?", message: "\(chart.isBarsEmpty())", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetValues(_ sender: Any) {
        chart.resetValues()
    }
    
    @IBAction func removeClickedBar(_ sender: Any) {
        chart.removeClickedBar()
    }
}

extension MainViewController: ChartProgressBarDelegate {
    func ChartProgressBar(_ chartProgressBar: ChartProgressBar, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
