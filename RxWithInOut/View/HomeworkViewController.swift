//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

final class HomeworkViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    // 테이블뷰에 보여줄 애들
    private lazy var sampleUsers = BehaviorSubject(value: sampleUserData)
    private let sampleUserData: [Person] = User().userInfo
    // 컬렉션뷰에 보여줄 애들
    private lazy var selectedUsers = BehaviorSubject(value: selectedUserData)
    private var selectedUserData: [String] = []
    
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        sampleUsers
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self)) { (row, element, cell) in
                cell.profileImageView.kf.setImage(with: URL(string: element.profileImage))
                cell.usernameLabel.text = element.name
                cell.detailButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let vc = HomeworkDetailViewController()
                        vc.nameContents = element.name
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        selectedUsers
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { (item, element, cell) in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Person.self)
            .bind(with: self) { owner, selectedUser in
                owner.selectedUserData.insert(selectedUser.name, at: 0)
                owner.selectedUsers.onNext(owner.selectedUserData)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .bind(with: self) { owner, value in
                print(value)
                
                let result = value.isEmpty ? owner.sampleUserData : owner.sampleUserData.filter { $0.name.contains(value) }
                owner.sampleUsers.onNext(result)
            }
            .disposed(by: disposeBag)
    }
}
 
extension HomeworkViewController {
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
