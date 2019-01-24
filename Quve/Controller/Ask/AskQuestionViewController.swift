//
//  AskQuestionViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 21/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class AskQuestionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var preferenceView: UIView!
    @IBOutlet weak var periodView: UIView!
    @IBOutlet weak var openSwitch: UISwitch!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var preferenceTextField: UITextField!
    @IBOutlet weak var periodTextField: UITextField!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var userPointLabel: UILabel!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var costStackView: UIStackView!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    let placeholderColor = #colorLiteral(red: 0.7233634591, green: 0.7233806252, blue: 0.7233713269, alpha: 1)
    
    let categoryPickerView = UIPickerView()
    let placePickerView = UIPickerView()
    let preferencePickerView = UIPickerView()
    let periodPickerView = UIPickerView()
    let costPickerView = UIPickerView()
    var textField: UITextField!
    
    let category: [String] = ["교육",
                              "사회·정치",
                              "컴퓨터",
                              "여행",
                              "게임",
                              "쇼핑",
                              "경제",
                              "생활",
                              "건강",
                              "어린이",
                              "예술",
                              "지역"]
    let place: [String] = ["서울특별시", "부산광역시", "인천광역시", "대구광역시", "대전광역시", "광주광역시", "울산광역시",
                           "경기도", "강원도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도",
                           "제주특별자치시", "세종특별자치시"]
    let preference: [String] = ["제한없음"]
    let period: [String] = ["30분(기본)"]
    let cost: [String] = ["500원(기본)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        contentTextView.textColor = placeholderColor
        setPickerView()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func setPickerView() {
        set(categoryPickerView)
        set(placePickerView)
        set(preferencePickerView)
        set(periodPickerView)
        set(costPickerView)
        categoryTextField.inputView = categoryPickerView
        placeTextField.inputView = placePickerView
        preferenceTextField.inputView = preferencePickerView
        periodTextField.inputView = periodPickerView
        costTextField.inputView = costPickerView
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTapGesture(sender: AnyObject)
    {
        view.endEditing(true)
    }
    
    private func set(_ picker: UIPickerView) {
        picker.backgroundColor = UIColor.white
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
    }
}

extension AskQuestionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor {
            textView.text = nil
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "질문은 15자 이내로 짧게 작성할수록 채택률이 높아집니다."
            textView.textColor = #colorLiteral(red: 0.7233634591, green: 0.7233806252, blue: 0.7233713269, alpha: 1)
        }
    }
}

extension AskQuestionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case categoryPickerView:
            return category.count
        case placePickerView:
            return place.count
        case preferencePickerView:
            return preference.count
        case periodPickerView:
            return period.count
        case costPickerView:
            return cost.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPickerView:
            return category[row]
        case placePickerView:
            return place[row]
        case preferencePickerView:
            return preference[row]
        case periodPickerView:
            return period[row]
        case costPickerView:
            return cost[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categoryPickerView:
            categoryTextField.text = category[row]
        case placePickerView:
            placeTextField.text = place[row]
        case preferencePickerView:
            preferenceTextField.text = preference[row]
        case periodPickerView:
            periodTextField.text = period[row]
        case costPickerView:
            costTextField.text = cost[row]
        default:
            break
        }
    }
}
