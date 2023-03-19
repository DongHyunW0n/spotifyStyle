//
//  PaywallViewController.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit


class PaywallViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    let bannerInfos : [BannerInfo] = BannerInfo.list // 리스트를 선언하고 배너인포의 리스트를 넣어보리기
    
    let colors : [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed]
    
    

    typealias Item = BannerInfo
    
    enum Section {
        
        case main
    }
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 프레젠테이션 : 디퍼블데이타소스
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, Items in
            
           
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else{
                return nil
            }
            
            cell.configure(Items)
            cell.backgroundColor = self.colors[indexPath.item]
            return cell
        })
        
       // 데이터 : 스냅샷
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main]) //메인이 한개니까
        snapshot.appendItems(bannerInfos, toSection: .main)
        dataSource.apply(snapshot)
        
        
        // 레이아웃 ; 컴포지셔널 레이아웃
        
        collectionView.collectionViewLayout = layout()
        
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        
        let groupsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200)) //그룹사이즈가 너비는 전체 화면에서 0.8만큼 차게, 높이는 200으로 고정해뒀으니 200으로 앱솔루트 !
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupsize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered// 옆에 공간이 없으면 자동으로 수직으로 돌리는데, 이 설정을 준다면 옆으로 계속 흐르게 해줌.
        section.interGroupSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
