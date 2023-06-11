//
//  ScrapBookViewController.swift
//  AnimalScrapBook
//
//  Created by Jimi Michael on 4/14/23.
//

// Jaisal Mehta jkmehta@iu.edu
// Jimi Michael jimimich@iu.edu
// Submission Date: 04/30/2023
// App Name: Animal Scrapbook

import Foundation
import UIKit
import CoreML


class ScrapBookViewController: UIViewController {
    
    var appDelegate: AppDelegate?
    var myModelRef: ScrapBookModel?
    
    @IBOutlet weak var correct: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    @IBAction func takePhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker,animated: true)
    }
    
    @IBAction func submitPhoto() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModelRef = self.appDelegate?.scrapBookModel
        
        guard let image = imageView.image else {
            return
        }
        guard let resizedImage = image.resize(to: CGSize(width: 224, height: 224)) else {
            return
        }
        //Model takes in a CVPixelBuffered image, a good format is kCVPixelFormatType_32ARGB
        guard let pixelBuffer = pixelBuffer(from: resizedImage) else {
            return
        }
        do {
            //Core ML model
            let config = MLModelConfiguration()
            let model = try MobileNetV2(configuration: config)
            
            // Prediction
            let prediction = try model.prediction(image: pixelBuffer)
            let predictedAnimal = String(prediction.classLabel)
            let stringArr = predictedAnimal.components(separatedBy: ", ")
            let newAnimalString: String = stringArr[0]
            correct.text = "Animal: \(newAnimalString)"
            if (myModelRef?.animals[newAnimalString] != nil) {
                myModelRef?.animals[newAnimalString]! += 1
            }
            else {
                myModelRef?.animals[newAnimalString] = 1
            }
            
            let notification = UNMutableNotificationContent()
            notification.title = "Animal ScrapBook"
            notification.body = "Animal Added!"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let request = UNNotificationRequest(identifier: "localNotification", content: notification, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                if error != nil {
                    print("\(String(describing: error))")
                }
                else {
                    print("notification successful")
                }
            })
        }
        catch {
            print("Error: \(error)")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(myModelRef?.animals, forKey: "dict")
        let dict = userDefaults.dictionary(forKey: "dict") ?? Dictionary<String, Int>()
    }
    
    func pixelBuffer(from image: UIImage) -> CVPixelBuffer? {
        // Create a dictionary to specify the pixel buffer attributes
        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]
        //Create a pixel buffer using the specified attributes
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height),
                                         kCVPixelFormatType_32ARGB, pixelBufferAttributes as CFDictionary, &pixelBuffer)
        guard status == kCVReturnSuccess, let unwrappedPixelBuffer = pixelBuffer else {
            return nil
        }
        CVPixelBufferLockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress = CVPixelBufferGetBaseAddress(unwrappedPixelBuffer)
        
        let context = CGContext(
            data: baseAddress,
            width: Int(image.size.width),
            height: Int(image.size.height),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(unwrappedPixelBuffer),
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        )
        //Draw the image into the bitmap context
        context?.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        //base address of the pixel buffer
        CVPixelBufferUnlockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return unwrappedPixelBuffer
    }
}



extension ScrapBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage else{
            return
        }
        imageView.image = image
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


