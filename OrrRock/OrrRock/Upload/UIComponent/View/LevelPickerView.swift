//
//  LevelPickerView.swift
//  OrrRock
//
//  Created by 이성노, Yeni Hwang on 2022/10/25.
//

import UIKit

protocol LevelPickerViewDelegate {
    func didLevelChanged(selectedLevel: Int)
    func setSeparatorColor()
}

class LevelPickerView: UIViewController, UISheetPresentationControllerDelegate {

    var isSuccess : Bool = false
    var level = Int()
    var delegate: LevelPickerViewDelegate?
    var pickerSelectValue = 0

    private let levelList: [String] = ["선택안함","V0","V1","V2","V3","V4","V5","V6","V7","V8","V9"]

    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }

    private lazy var titleLabel : UILabel = {
        let title = UILabel()
        title.text = "레벨을 선택해주세요"
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        title.textColor = .black
        return title
    }()

    private lazy var levelContentView : UIView = {
        let view = UIView()
        return view
    }()

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: 150, width: self.view.bounds.width, height: 180.0)
        picker.backgroundColor = .orrGray1
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var saveButton : UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.orrUPBlue ?? .red, for: .normal)
        button.setBackgroundColor(.orrGray2 ?? .red, for: .disabled)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapSaveButton), for: .touchDown)
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpDelegate()
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: pickerSelectValue, inComponent: 0)
        self.pickerView.selectRow(pickerSelectValue, inComponent: 0, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        delegate?.setSeparatorColor()
    }
    
    private func setUpDelegate(){
        sheetPresentationController.delegate = self
        sheetPresentationController.prefersGrabberVisible = false
        sheetPresentationController.detents = [.medium()]
    }
}

extension LevelPickerView {

    private func setUpLayout(){
        view.backgroundColor = .orrGray1

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(OrrPadding.padding4.rawValue)
            $0.leading.equalToSuperview().offset(OrrPadding.padding4.rawValue)
            $0.trailing.equalToSuperview().offset(-OrrPadding.padding4.rawValue)
        }

        view.addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(OrrPadding.padding1.rawValue)
            $0.leading.equalToSuperview().offset(OrrPadding.padding4.rawValue)
            $0.trailing.equalToSuperview().offset(-OrrPadding.padding4.rawValue)
            $0.height.equalTo(300)
        }

        view.addSubview(saveButton)
        saveButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-34)
            $0.leading.trailing.equalToSuperview().offset(OrrPadding.padding3.rawValue)
            $0.trailing.equalToSuperview().offset(-OrrPadding.padding3.rawValue)
            $0.height.equalTo(56)
        }
    }

    @objc func tapSaveButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        delegate?.didLevelChanged(selectedLevel: level)
    }

    @objc func tapCancelButton(_ sender: UIBarButtonItem){
        self.dismiss(animated: true)
    }
}

extension LevelPickerView : UIPickerViewDelegate,UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // pickerView pickerView에 컴포넌트를 넣어줍니다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levelList.count
    }

    // 선택된 값
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        level = row - 1
    }

    // 선택된 값을 리턴
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        levelList[row]
    }
}
