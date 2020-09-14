//
//  AppDetailViewController.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/08.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var corperation: UILabel!
    @IBOutlet weak var averageUserRating: UILabel!
    
    @IBOutlet weak var starRating: UIStackView!
    @IBOutlet weak var userRatingCount: UILabel!
    
    @IBOutlet weak var currentVersion: UILabel!
    @IBOutlet weak var contentAdvisorRating: UILabel!
    @IBOutlet weak var releaseNotes: UILabel!
    
    @IBOutlet weak var lastVersionTime: UILabel!
    @IBOutlet weak var descriptionMessage: UILabel!
    
    @IBOutlet weak var sellerName: UILabel!
    
    @IBOutlet weak var realeseNoteCell: UIView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var thumbCollectionView: UICollectionView!
    @IBOutlet weak var releaseMore: UILabel!
    @IBOutlet weak var descriptionMore: UILabel!
    
    @IBOutlet weak var infoCoperation: UILabel!
    @IBOutlet weak var infoCategory: UILabel!
    @IBOutlet weak var infoAge: UILabel!
    @IBOutlet weak var infoSellerName: UILabel!
    
    
    var param :AppDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.thumbCollectionView.delegate = self
        self.thumbCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 460)
        self.thumbCollectionView.collectionViewLayout = layout
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = nil
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(releaseViewTapped))
        self.realeseNoteCell.addGestureRecognizer(tapGestureRecognizer)
        let descriptionGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(descriptionViewMapTapped))
        self.descriptionMessage.addGestureRecognizer(descriptionGestureRecognizer)
        self.descriptionMessage.isUserInteractionEnabled = true
        
        self.setData()
    }
    @IBAction func sendAppStore(_ sender: Any) {
        if let trackViewUrl = param?.trackViewUrl {
            guard let url = URL(string: trackViewUrl), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func sendPersonalProcessPage(_ sender: Any) {
        if let trackViewUrl = param?.trackViewUrl {
            guard let url = URL(string: trackViewUrl), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func sendSellerSite(_ sender: Any) {
        if let sellerUrl = param?.sellerUrl {
            guard let url = URL(string: sellerUrl), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func releaseViewTapped(sender: UITapGestureRecognizer) {
        self.releaseNotes.numberOfLines = 0
        self.releaseMore.isHidden = true
    }
    @objc func descriptionViewMapTapped(sender: UITapGestureRecognizer) {
        self.descriptionMessage.numberOfLines = 0
        self.descriptionMore.isHidden = true
    }
    
    private func setData() {
        if let appInfo = param {
            self.appIcon.load(url: appInfo.artworkUrl512 ?? "")
            self.appName.text = appInfo.trackName
            let sellerName = appInfo.sellerName
            self.corperation.text = sellerName
            self.infoCoperation.text = sellerName
            self.sellerName.text = sellerName
            self.infoSellerName.text = sellerName
            self.averageUserRating.text = String(format: "%.1f",appInfo.averageUserRating ?? 0)
            self.starRating.starRating(score: appInfo.averageUserRating ?? 0)
            self.descriptionMessage.text = appInfo.descriptionString
            self.releaseNotes.text = appInfo.releaseNotes
            self.currentVersion.text = String(localized: "version").appending(appInfo.version ?? "")
            self.contentAdvisorRating.text = appInfo.contentAdvisoryRating
            self.infoAge.text = appInfo.contentAdvisoryRating
            self.genre.text = appInfo.genres?[0] ?? ""
            self.infoCategory.text = self.genre.text
            self.userRatingCount.text = ConvertUtil.userRatingCount(appInfo.userRatingCountForCurrentVersion ?? 0).appending(String(localized: "count_evaluation"))
            self.lastVersionTime.text = ConvertUtil.getDayCountFromCurrent(value: appInfo.currentVersionReleaseDate ?? "")
            self.thumbCollectionView.reloadData()
        }
    }
    
    @IBAction func share(_ sender: Any) {
        let textToShare = self.param?.trackName ?? ""
        
        let appLink = String( "http://iTunes.Apple.com/app/id").appending(String(self.param?.trackId ?? 0))
        if let myWebsite = URL(string: appLink) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ _collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = thumbCollectionView.dequeueReusableCell(withReuseIdentifier: "thumb_cell", for: indexPath) as? ThumbnailCollectionViewCell
        cell?.setImage(self.param?.screenshotUrls?[indexPath.row] ?? "")
        return cell ?? ThumbnailCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.param?.screenshotUrls?.count ?? 0
    }
    
}
