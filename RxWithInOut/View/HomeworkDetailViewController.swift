//
//  HomeworkDetailViewController.swift
//  RxWithInOut
//
//  Created by 조우현 on 2/19/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeworkDetailViewController: UIViewController {
    
    let viewModel = HomeworkDetailViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        bind()
    }

    private func bind() {
        let input = HomeworkDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.nameContents
            .bind(with: self) { owner, name in
                owner.navigationItem.title = name
            }
            .disposed(by: disposeBag)
    }
}
