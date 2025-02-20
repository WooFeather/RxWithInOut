//
//  HomeworkDetailViewModel.swift
//  RxWithInOut
//
//  Created by 조우현 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkDetailViewModel {
    struct Input {
        
    }
    
    struct Output {
        let nameContents: Observable<String>
    }
    
    var nameContents = BehaviorSubject(value: "")
    
    func transform(input: Input) -> Output {
        return Output(nameContents: nameContents)
    }
}
