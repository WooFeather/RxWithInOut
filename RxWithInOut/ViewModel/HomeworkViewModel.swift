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
    
    private let disposeBag = DisposeBag()
    
    // 테이블뷰 원본 데이터
    private var sampleUserData: [Person] = User().userInfo
    // 컬렉션뷰 원본 데이터
    private var selectedUserNameData: [String] = []
    
    struct Input {
        // 검색버튼 탭
        let searchButtonTapped: ControlEvent<Void>
        // 서치텍스트
        let searchText: ControlProperty<String>
        // 테이블뷰 셀을 탭했을 때 selectedName
        let selectedName: PublishSubject<String>
    }
    
    struct Output {
        // 테이블뷰에 보여줄 데이터
        let sampleUsers: BehaviorSubject<[Person]>
        // 컬렉션뷰에 보여줄 데이터
        let selectedUsers: BehaviorSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        // output으로 내보낼 테이블뷰 데이터
        let userList = BehaviorSubject(value: sampleUserData)
        // output으로 내보낼 컬렉션뷰 데이터
        let selectedNameList = BehaviorSubject(value: selectedUserNameData)
        
        input.searchButtonTapped
            .withLatestFrom(input.searchText)
            .bind(with: self) { owner, value in
                let trimmedText = value.trimmingCharacters(in: .whitespaces)
                let result = trimmedText.isEmpty ? owner.sampleUserData : owner.sampleUserData.filter { $0.name.contains(trimmedText) }
                
                userList.onNext(result)
            }
            .disposed(by: disposeBag)
        
        input.selectedName
            .bind(with: self) { owner, value in
                owner.selectedUserNameData.insert(value, at: 0)
                selectedNameList.onNext(owner.selectedUserNameData)
            }
            .disposed(by: disposeBag)
        
        return Output(
            sampleUsers: userList,
            selectedUsers: selectedNameList
        )
    }
}
