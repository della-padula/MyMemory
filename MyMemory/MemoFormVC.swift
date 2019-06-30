//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by TaeinKim on 30/06/2019.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject: String!
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        let tempContents = self.contents.text as NSString
        
        //Content 추출하기
        let realContents = tempContents.substring(with: NSRange(location: (self.subject as NSString).length,
                                                length: tempContents.length - (self.subject as NSString).length))
        
        data.title = self.subject
        data.contents = realContents
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        self.contents.delegate = self
    }
    
    // After Selecting Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage{
            self.preview.image = editedImage
            picker.dismiss(animated: false)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString // as?, as! 그냥 as
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
    
}
