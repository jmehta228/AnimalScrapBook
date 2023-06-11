- The purpose of the app is to add animals, through a split view controller segue, to the ScrapBook which is implemented through a TableViewController within a tab bar view. The addition and deletion of animals into the scrapbook can be done with buttons and/or the iPhone/device camera.

- Furthermore the app does indeed incorporate the speciifed app requirements for the project such as buttons, text labels, and text fields. Also, the app includes views such as a View Controller, Split View Controller, Tab Bar Controller, and a Table View Controller.

- ViewController.swift:
    - "Add" button -> @IBAction func showScrapBook(_ sender: Any)
    - "Delete animal" button ->  @IBAction func deleteCertainData(_ sender: Any)
    - Textfield region for delete button -> @IBOutlet weak var deleteField: UITextField!
    - "Delete All" button -> @IBAction func deleteData(_ sender: Any)

- ScrapBookViewController.swift:
    - "Take Photo" button -> @IBAction func takePhoto()
    - "Submit" button -> @IBAction func submitPhoto()
    - ImageView -> @IBOutlet var imageView: UIImageView!
    - Label representing the name of the animal based on the photo taken -> @IBOutlet weak var correct: UILabel!

- ScrapBookTableViewController.swift:
    - Prototype cell (connected to AnimalTableViewCell.swift)
    - Label representing the animal name
    - Label representing the frequency count for each animal

- AnimalTableViewCell.swift:
    - Label representing the animal name -> @IBOutlet weak var nameLabel: UILabel!
    - Label representing the frequency count for each animal -> @IBOutlet weak var frequencyLabel: UILabel!
    
- Tab Bar View Controller contains views corresponding to the ViewController.swift, ScrapBookViewController.swift, ScrapBookTableViewController.swift, and AnimalTableViewCell.swift source code files.

- To shortly describe our application for our final project, we essentially want to create a animal scrapbook app. The basis of this app will implement an apple developer provided createML model which will use the dataset to essentially classify an animal somebody takes a picture of in our app. The animal will then be recorded in an archive, also including how many times that certain animal has been captured. The app implements UIIMagePicker to classify whatever animal you take a picture of. The app will also implement notifications to remind the user to get on the app and do their daily animal finding. The goal of this app is to have the user collect animals and learn about ones they don't know about in a digital way.