//
//  MainProxyListViewController.swift
//  V2RayC
//
//  Created by cedric on 2018/8/25.
//  Copyright © 2018年 cedric. All rights reserved.
//

import Cocoa
import Security
import SecurityFoundation


class MainProxyListViewController: NSViewController {
    let collectionView: NSCollectionView = {
        let v = NSCollectionView()
        return v
    }()
    let scrollView = NSScrollView()
    let viewModel = MainProxyListViewModel()

    var runTask: Process!

    // MARK: - Views About
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // set flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 266, height: 154)
        flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 51
        flowLayout.minimumLineSpacing = 38
        collectionView.collectionViewLayout = flowLayout
        // register cell
        collectionView.register(ProxyItemAddCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ProxyItemAddCell"))
        collectionView.register(ProxyItemCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ProxyItemCell"))
        // other config
        collectionView.allowsEmptySelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.isSelectable = true
    }
    
    func setupScrollView() {
        scrollView.documentView = collectionView
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
    }

    // MARK: - Life Cycle
    override func viewWillLayout() {
        super.viewWillLayout()
        scrollView.frame = view.bounds
        collectionView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupScrollView()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        collectionView.reloadData()
    }
}

// MARK: - Main Menu Event
extension MainProxyListViewController {
    func refreshSubscribe() {
//        viewModel.clearAllSubscibe()
//        viewModel.fetchFromSubscribe { [weak self] in
//            if let ss = self {
//                DispatchQueue.main.async {
//                    ss.collectionView.reloadData()
//                }
//            }
//        }
    }
}

extension MainProxyListViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let manager = ProxyListManager.shared
        return manager.proxyModels.count + 1
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        var identifier: String!
        let manager = ProxyListManager.shared
        if indexPath.item < manager.proxyModels.count {
            identifier = "ProxyItemCell"
        } else {
            identifier = "ProxyItemAddCell"
        }
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), for: indexPath)
        if let itemCell = cell as? ProxyItemCell {
            itemCell.fillWith(model: manager.proxyModels[indexPath.item])
        }
        return cell
    }

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard indexPaths.count == 1 else {
            return
        }
        let manager = ProxyListManager.shared
        if let indexPath = indexPaths.first {
            // 新增还是选中
            if indexPath.item == manager.proxyModels.count {
                // 新增
                let sb = NSStoryboard(name: "Main", bundle: Bundle.main)
                if let vc = sb.instantiateController(withIdentifier: "SelectAddMethodViewController") as? SelectAddMethodViewController {
                    vc.delegate = self
                    presentAsSheet(vc)
                }
            } else {
                // 选中
                manager.startProxy(index: indexPath.item)
                collectionView.reloadData()
            }
        }
        collectionView.selectionIndexPaths.removeAll()
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier! == "ToAddProxy" {
            guard let addVC = segue.destinationController as? AddProxyViewController else {
                return
            }
            addVC.delegate = self as AddProxyViewDelegate
        }
    }
}

extension MainProxyListViewController: AddProxyViewDelegate {
    func addSubscribeUrlSuccess(subscribeUrl: String) {

    }

    func addProxySuccess(proxy: ProxyModel) {
        ProxyListManager.shared.addProxy(list: [proxy], at: nil)
        collectionView.reloadData()
    }
}

extension MainProxyListViewController: SelectAddMethodViewControllerDelegate {
    func normalButtonClicked() {
        let sb = NSStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = sb.instantiateController(withIdentifier: "AddProxyViewController") as? AddProxyViewController {
            presentAsSheet(vc)
        }
    }
    
    func fromConfigFileButtonClicked() {
        let sb = NSStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = sb.instantiateController(withIdentifier: "AddConfigFileProxyViewController") as? AddConfigFileProxyViewController {
            presentAsSheet(vc)
        }
    }
    
    func fromSubscribeButtonClicked() {
        let sb = NSStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = sb.instantiateController(withIdentifier: "AddSubscribeViewController") as? AddSubscribeViewController {
            let subscribeURLs = ProxyListManager.shared.subscribeURLs
            if subscribeURLs.count > 0 {
                vc.initialTextString = subscribeURLs.joined(separator: "\n")
            }
            vc.delegate = self
            presentAsSheet(vc)
        }
    }
}

extension MainProxyListViewController: AddSubscribeViewControllerDelegate {
    func confirmButtonClicked(str: String) {
        var urls = [String]()
        let arr = str.components(separatedBy: "\n")
        for url in arr {
            if url.hasPrefix("http") {
                urls.append(url)
            }
        }
        ProxyListManager.shared.updateSubscribeURL(urls: urls)
    }
}

extension MainProxyListViewController: AddConfigFileProxyViewControllerDelegate {
    func addConfigFileProxyComplete(proxyModel: ProxyModel) {
        ProxyListManager.shared.addProxy(list: [proxyModel], at: 0)
        collectionView.reloadData()
    }
}
