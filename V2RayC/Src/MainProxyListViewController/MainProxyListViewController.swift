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

    // MARK: - Life Cycle
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // set flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 256, height: 144)
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
        // add to view
//        collectionView.frame = view.bounds
//        view.addSubview(collectionView)
    }

    func setupScrollView() {
        scrollView.documentView = collectionView
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.mockData()
        setupCollectionView()
        setupScrollView()
    }
}

extension MainProxyListViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.proxyItems.count + 1
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        var identifier: String!
        if indexPath.item < viewModel.proxyItems.count {
            identifier = "ProxyItemCell"
        } else {
            identifier = "ProxyItemAddCell"
        }
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), for: indexPath)
        if let itemCell = cell as? ProxyItemCell {
            itemCell.fillWith(model: viewModel.proxyItems[indexPath.item])
        }
        return cell
    }

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if indexPaths.count == 1 {
            // 新增还是选中
            if indexPaths.first!.item == viewModel.proxyItems.count {
                performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "ToAddProxy"), sender: self)
                collectionView.selectionIndexes.removeAll()
            } else {
                let model = viewModel.proxyItems[indexPaths.first!.item]
                generateLaunchdPlistFromProxyModel(model: model)
                DispatchQueue.global().async {
                    _ = runCommandLine(binPath: "/bin/launchctl", args: ["unload", kV2rayCPlistPath])
                    _ = runCommandLine(binPath: "/bin/launchctl", args: ["load", kV2rayCPlistPath])
                }
            }
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier!.rawValue == "ToAddProxy" {
            guard let addVC = segue.destinationController as? AddProxyViewController else {
                return
            }
            addVC.delegate = self as AddProxyViewDelegate
        }
    }
}

extension MainProxyListViewController: AddProxyViewDelegate {
    func addProxySuccess(proxy: ProxyModel) {
        viewModel.proxyItems.append(proxy)
        collectionView.reloadData()
    }
}
