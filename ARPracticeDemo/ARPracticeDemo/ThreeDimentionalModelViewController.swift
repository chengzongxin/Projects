//
//  ThreeDimentionalModelViewController.swift
//  ARPracticeDemo
//
//  Created by Joe on 2020/5/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class ThreeDimentionalModelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        sessionLoadData()
        
    }
    func sessionLoadData(){
        //创建URL对象
        let urlString = "http://hangge.com"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
         
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request,
            completionHandler: {(data, response, error) -> Void in
                if error != nil{
                    print(error.debugDescription)
                }else{
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    print(str!)
                }
        }) as URLSessionTask
         
        //使用resume方法启动任务
        dataTask.resume()
    }

}
