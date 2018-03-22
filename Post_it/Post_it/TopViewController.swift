//
//  TopViewController.swift
//  Post_it
//
//  Created by Rei Yamaguchi on 2018/03/16.
//  Copyright © 2018年 hideandseek.inc. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var inputURL: UITextField!
    @IBOutlet weak var title_image: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputURL.delegate = self
        title_image.titleView = UIImageView(image: UIImage(named: "title"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // keybord func
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // list
    var recentBoardList = ["Why people needs water.", "Do we needs AI in this world?", "How many times you get regret?", "Can We eat a human?", "Bussiness makes  wars", "Music is for?"]
    
    var sectionIndex:[String] = ["Recent"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentBoardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentBoardCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = recentBoardList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionIndex[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionIndex.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recentBoardList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
