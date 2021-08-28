//
//  DetailViewController.swift
//  AppleNewsFeed
//
//  Created by nadezda.gura
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    //variable declaration
    
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
    var webUrlString = String()
    var titleString = String()
    var contentString = String()
    var newsImage:UIImage?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var readFullButton: UIButton!
    @IBOutlet weak var savedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFullButton.layer.cornerRadius  = 12
        readFullButton.tintColor = .label
        self.title = "Article"
        
        
        titleLabel.text = titleString
        contentTextField.text = contentString
        newsImageView.image = newsImage
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

    
    }
    //function for saving data
    func saveData(){
        do{
            try context?.save()
            basicAlert(title: "SAVED!", message: "To see your saved Article go to Saved Tab bar")
        }catch {
            print(error.localizedDescription)
            }
            
        }

    @IBAction func saveButtonTapped(_ sender: Any) {
        //saving new item (content, image, url)
        let newItem = Items(context: self.context!)
        newItem.newsTitle = titleString
        newItem.newsContent = contentString
        newItem.url = webUrlString
        //saving image as binary data
        
        guard let imageData:Data = newsImage?.pngData() else {
            return
        }
        if !imageData.isEmpty{
            newItem.image = imageData
            
        }
        
        self.savedItems.append(newItem)
        saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination:WebViewController = segue.destination as!
        WebViewController
        destination.urlString = webUrlString
    }
    
    
    
    }
    

