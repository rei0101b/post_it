//
//  PostViewController.swift
//  Post_it
//
//  Created by Rei Yamaguchi on 2018/03/16.
//  Copyright © 2018年 hideandseek.inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PostViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet var gesturView: UIView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var title_image: UINavigationItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var border1: UIButton!
    @IBOutlet weak var border2: UIButton!
    @IBOutlet weak var border3: UIButton!
    @IBOutlet weak var border4: UIButton!
    @IBOutlet weak var border5: UIButton!
    var borderColor = "F02B5664"
    var docRef: DocumentReference!
    let uuidString = UUID().uuidString
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title_image.titleView = UIImageView(image: UIImage(named: "title"))
        textView.delegate = self
        docRef = Firestore.firestore().document("sampleData/post")
        setCloseOnKeyboard()
        setPostBorderColor()
        setGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPostBorderColor() {
        textView.layer.borderColor = UIColor.border1()
        textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20)
        textView.layer.borderWidth = 5.0
        textView.layer.cornerRadius = 29.0
        textView.layer.masksToBounds = true
    }
    
    func setGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        gesturView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func panGesture(sender:UIPanGestureRecognizer) {
        switch (sender.state) {
        case .began:
            print("pan start")
            break
        case .ended:
            print("pan end")
            UIView.transition(with: gesturView, duration: 0.7, options: [.transitionCurlUp], animations: nil, completion: nil)
            guard let postText = textView.text, validate(textView: textView) else { return }
            let dataToSend: [String: Any] = ["text": postText, "border": borderColor, "deleteflag": false]
            print(dataToSend)
            docRef.setData(dataToSend) { (error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    print("data has been save")
                }
            }
            break
        default:
            break
        }
    }
    
    func validate(textView textView: UITextView) -> Bool {
        guard let text = textView.text, !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
    
    
    
    
    // keybord func
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        if text == "\n" {
//            print("########改行")
//           return false;
//        }
        let numberOfChars = newText.characters.count
        return numberOfChars < 140
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    func setCloseOnKeyboard() {
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        textView.inputAccessoryView = kbToolBar
    }

    @IBAction func changeBorder1(_ sender: Any) {
        borderColor = "F02B5664"
        textView.layer.borderColor = UIColor.border1()
    }
    
    @IBAction func changeBorder2(_ sender: Any) {
        borderColor = "F8E71C64"
        textView.layer.borderColor = UIColor.border2()
    }
    
    @IBAction func changeBorder3(_ sender: Any) {
        borderColor = "29D00264"
        textView.layer.borderColor = UIColor.border3()
    }
    
    @IBAction func changeBorder4(_ sender: Any) {
        borderColor = "0275D064"
        textView.layer.borderColor = UIColor.border4()
    }
    
    @IBAction func changeBorder5(_ sender: Any) {
        borderColor = "BF1CF864"
        textView.layer.borderColor = UIColor.border5()
    }
    
    @IBAction func camera_prot(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://post-it-b02f3.appspot.com/")
        // Data in memory
        let data = Data()
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/mashu.jpg")
        let imageData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "IMG_4118"), 0.1)!
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("Uh-oh, an error occurred!")
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()
            let deta = downloadURL?.absoluteString
            let dataToSend: [String: Any] = ["image": deta]
            self.docRef.setData(dataToSend) { (error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    print("image has been save")
                }
            }
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
