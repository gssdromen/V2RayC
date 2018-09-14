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
    var selectAddMethodViewController: SelectAddMethodViewController?

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
        // "https://v2ray.generalapisys.com/client/api.php?token=15b4a279-0d76-4e0f-b395-ce490575da7a&s=v2ray.subscribe&pid=246"
//        viewModel.loadFromDisk()
        collectionView.reloadData()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        viewModel.saveToDisk()
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
                let sb = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: Bundle.main)
                if let vc = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SelectAddMethodViewController")) as? SelectAddMethodViewController {
                    vc.delegate = self
                    selectAddMethodViewController = vc
                    presentViewControllerAsSheet(vc)
                }
            } else {
                for i in 0 ..< viewModel.proxyItems.count {
                    let model = viewModel.proxyItems[i]
                    if i == indexPaths.first!.item {
                        model.isSelected = !model.isSelected
                    } else {
                        model.isSelected = false
                    }
                    
                    if let from = model.from {
                        switch from {
                        case ProxyFrom.subscribtion:
                            let configModel = genDefaultProxyConfigModel()
                            configModel.fillWith(model: model)
                            model.configPath = configModel.writeToConfigJsonFile()
                        case ProxyFrom.custom:
                            break
                        case ProxyFrom.normal:
                            let configModel = genDefaultProxyConfigModel()
                            configModel.fillWith(model: model)
                            model.configPath = configModel.writeToConfigJsonFile()
                        }
                    }
                    generateLaunchdPlistFromProxyModel(model: model)
                    DispatchQueue.global().async {
                        _ = runCommandLine(binPath: "/bin/launchctl", args: ["unload", kV2rayCPlistPath])
                        _ = runCommandLine(binPath: "/bin/launchctl", args: ["load", kV2rayCPlistPath])
                    }
                }
                collectionView.reloadData()
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
    func addSubscribeUrlSuccess(subscribeUrl: String) {
        viewModel.fetchSubscibeFrom(url: subscribeUrl, complete: { [weak self] in
            if let ss = self {
                ss.collectionView.reloadData()
            }
        })
    }

    func addProxySuccess(proxy: ProxyModel) {
        viewModel.proxyItems.append(proxy)
        collectionView.reloadData()
    }
}

extension MainProxyListViewController: SelectAddMethodViewControllerDelegate {
    func normalButtonClicked() {
        let sb = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: Bundle.main)
        if let vc = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AddProxyViewController")) as? AddProxyViewController {
            presentViewControllerAsSheet(vc)
        }
    }
    
    func fromConfigFileButtonClicked() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.begin { [weak self] (result) -> Void in
            if result == NSApplication.ModalResponse.OK {
                if let url = openPanel.url {
                    if let ss = self {
                        let proxyModel = ProxyModel()
                        proxyModel.from = ProxyFrom.custom
                        proxyModel.configPath = url.path
                        ss.viewModel.proxyItems.insert(proxyModel, at: 0)
                        ss.collectionView.reloadData()
                        ss.view.window?.close()
                    }
                }
            }
        }
    }
    
    func fromSubscribeButtonClicked() {
        let sb = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: Bundle.main)
        if let vc = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AddSubscribeViewController")) as? AddSubscribeViewController {
            vc.delegate = self
            presentViewControllerAsSheet(vc)
        }
    }
}

extension MainProxyListViewController: AddSubscribeViewControllerDelegate {
    func confirmButtonClicked(str: String) {
        print(str)
    }
}
