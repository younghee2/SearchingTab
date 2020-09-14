//
//  SearchedListTableViewController.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/08.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit
import ObjectMapper


class SearchedListTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    var searchedList:[AppDTO] = [AppDTO]()
    
    var isEndOfPage = false
    var addDataCallCount: Int = 0
    let pageSize:Int = 25
    var currentKeyword = ""
    
    deinit {
        SNotification.removeObserver(SearchingTabNotification.SEARCH_KEYWORD.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.prefetchDataSource = self
        SNotification.addObserver(self, selector: #selector(onReceiveData(_:)), name: SearchingTabNotification.SEARCH_KEYWORD.rawValue, object: nil)
    }
    
    @objc func onReceiveData(_ notification:Notification) {
        guard let keyword = notification.userInfo?["keyword"] as? String else { return }
        self.currentKeyword = keyword
        self.isEndOfPage = false
        self.searchedList.removeAll()
        self.tableView.reloadData()
        print(currentKeyword)
        self.requestSearchList(keyword: currentKeyword,page: addDataCallCount)
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchedList.count == indexPath.row {
                self.addData()
            }
        }
    }
    
    func addData() {
        guard isEndOfPage else {
            addDataCallCount += 1
            self.requestSearchList(keyword: currentKeyword,page: addDataCallCount)
            return
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "app_cell", for: indexPath) as! AppListTableViewCell
        cell.setData(appInfo: searchedList[indexPath.row])
        return cell
    }
    
    private func requestSearchList(keyword:String, page:Int) {
        request(currentKeyword,currentPage: page) { responseObject, error in
            guard let responseObject = responseObject, error == nil else {
                print(error ?? "")
                return
            }
            if let results = responseObject["results"] as? Array<Any> {
                if let response = Mapper<AppDTO>().mapArray(JSONObject: results) {
                    if response.count == 0 {
                        self.isEndOfPage = true
                    } else {
                        self.searchedList += response
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func request(_ keyword: String, currentPage:Int,completion: @escaping([String:Any]?, Error?) -> Void) {
        let param = ["term":keyword,
                     "country":"kr",
                     "media":"software",
                     "limit":String(pageSize),
                     "offset":String(currentPage)]

        
        var urlComponent = URLComponents(string: "http://itunes.apple.com/search")
        urlComponent?.queryItems = param.map{(key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        if let url = urlComponent?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) {data,response,error in
                guard let data = data , let response = response as? HTTPURLResponse,
                    (200 ..< 300) ~= response.statusCode,
                    error == nil else {
                        completion(nil, error)
                        return
                }
                let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
                
                completion(responseObject, nil)
            }
            task.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "AppDetail") as? AppDetailViewController else {
            return
        }
        vc.param = searchedList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
