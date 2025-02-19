//
//  HomeworkViewModel.swift
//  RxWithInOut
//
//  Created by 조우현 on 2/19/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkViewModel {
    
    struct Input {
        // tableView의 cell을 탭
        let tableViewModelSelected: ControlEvent<Person>
        // searchBar의 search버튼을 탭
        // cell 안의 더보기 버튼을 탭
    }
    
    struct Output {
        // tableView의 cell을 탭
        let userName: Observable<String>
        // tableView에 데이터 보여주기?
        // collectionView에 데이터 보여주기?
    }
    
    func transform(input: Input) -> Output {
        
        let userName = input.tableViewModelSelected
            .map { $0.name }
        
        return Output(userName: userName)
    }
}
