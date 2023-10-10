//
//  ViewController.swift
//  MVVM
//
//  Created by 성현주 on 10/1/23.
//

import UIKit

import RxSwift
import SnapKit

final class ViewController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: ViewModelType
    var disposeBag = DisposeBag()
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI components
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("tap", for: .normal)
        button.backgroundColor = .systemGray
        return button
    }()
    
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: self.viewModel as! ViewModel)
        configureUI()
        setUI()
    }
    
    //MARK: -CustomMethod
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(button)
    }
    func setUI() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
   
    private func bind(viewModel: ViewModel) {
        self.viewModel.number
          .drive(self.label.rx.text)
          .disposed(by: self.disposeBag)
        
        self.button.rx.tap
          .bind(to: viewModel.tap)
          .disposed(by: self.disposeBag)
      }



}

