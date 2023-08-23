//
//  PhotoSelectorController.swift
//  Instagram
//
//  Created by Angela Terao on 23/08/2023.
//

import UIKit

class PhotoSelectorController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        setupNavigationButtons()
        
        self.modalPresentationCapturesStatusBarAppearance = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func handleNext() {
        print("Handeling next button")
        
    }
    
    @objc private func handleCancel() {
        self.dismiss(animated: true)
    }
    
}
