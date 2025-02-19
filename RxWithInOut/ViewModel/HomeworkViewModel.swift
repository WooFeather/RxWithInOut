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
        let searchButtonTapped: Observable<ControlProperty<String>.Element>
        // cell 안의 더보기 버튼을 탭
        // let detailButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        // tableView의 cell을 탭
        let userName: Observable<String>
        // 검색과 필터링
        let trimmedSearchText: Observable<String>
        // cell 안의 더보기 버튼을 탭
        // let detailButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let userName = input.tableViewModelSelected
            .map { $0.name }
        
        let trimmedSearchText = input.searchButtonTapped
            .map {
                let value = $0.trimmingCharacters(in: .whitespaces)
                return value
            }
        
        return Output(
            userName: userName,
            trimmedSearchText: trimmedSearchText
        )
    }
}
