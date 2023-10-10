//
//  ViewModel.swift
//  practice-MVVM
//
//  Created by 성현주 on 10/10/23.
//

import Foundation
import RxRelay
import RxCocoa
import RxSwift

protocol ViewModelType {
  var tap: PublishRelay<Void> { get }
  var number: Driver<String> { get }
}

final class ViewModel: ViewModelType {
  // input
  let tap = PublishRelay<Void>()
    
  // output
  let number: Driver<String>
    
  private let model = BehaviorRelay<Model>(value: .init(number: 100))
    
  let disposeBag = DisposeBag()
    
  init() {
    self.number = self.model
      .map { "\($0.number)" }
      .asDriver(onErrorRecover: { _ in .empty() })
        
    self.tap
      .withLatestFrom(model)
      .map { model -> Model in
        var nextModel = model
        nextModel.number += 1
        return nextModel
      }.bind(to: self.model)
      .disposed(by: disposeBag)
  }
}
