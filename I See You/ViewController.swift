//
//  ViewController.swift
//  I See You
//
//  Created by Charles Martin Reed on 1/28/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load test image
        guard let image = UIImage(named: "testPicture") else { return }
        imageView?.image = image
        
        guard let cgImage = image.cgImage else { return }
        
        //let faceDetect = VNDetectFaceRectanglesRequest - detects the rough position of face in a photo
        //let faceDetailsDetect = VNDetectFaceLandmarksRequest - detects facial aspects like eyes, nose. Recommended to handle this asynchronously and then push it back to the main thread.
        //TODO: refactor this into a seperate method, soon
        let request = VNDetectFaceLandmarksRequest { [weak self] request, error in
            if let observations = request.results as? [VNFaceObservation] {
                DispatchQueue.main.async {
                    //render the result
                }
        } else {
                print(error?.localizedDescription ?? "No observations available")
            }
        }
        //prepare to run request
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        DispatchQueue.global().async {
            
            do {
                try handler.perform([request])
            } catch {
                print(error.localizedDescription)
            }
        }

    }
    
    override func loadView() {
        //this image view is our view
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFit
        view = imageView
    }


}

