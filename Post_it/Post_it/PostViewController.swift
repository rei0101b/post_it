//
//  PostViewController.swift
//  Post_it
//
//  Created by Rei Yamaguchi on 2018/03/16.
//  Copyright © 2018年 hideandseek.inc. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    
    @IBOutlet weak var title_image: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title_image.titleView = UIImageView(image: UIImage(named: "title"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
