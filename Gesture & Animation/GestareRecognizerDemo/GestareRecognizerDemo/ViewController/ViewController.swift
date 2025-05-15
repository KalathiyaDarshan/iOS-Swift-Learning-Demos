//
//  ViewController.swift
//  GestareRecognizerDemo
//
//  Created by mac on 13/09/24.
//
/// Thare are 5 types of Gesture
/*
    1. UITapGestureRecognizer – Detects tap gestures (single or multiple taps).
    2. UIPinchGestureRecognizer – Detects pinch gestures (for zooming in and out).
    3. UIRotationGestureRecognizer – Detects rotation gestures (for rotating objects).
    4. UISwipeGestureRecognizer – Detects swipe gestures in a specific direction.
    5. UIPanGestureRecognizer – Detects pan (dragging) gestures.
*/
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var arrObjGesture: [GestureProperty] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "GestureCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "GestureCell")
        gestureObjectSet()
    }
    
    func gestureObjectSet(){
        
        // Create individual gesture recognizers
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        
        // Set the direction of the swipe (right in this case)
        swipeRight.direction = .right
        
        let pinchGesture =  UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        
        let obj1 = GestureProperty.init(name: "Tap Gesture", viewColor: .yellow, gestureType: tapGesture)
        let obj2 = GestureProperty.init(name: "swipe Gesture", viewColor: .systemPink, gestureType: swipeRight)
        let obj3 = GestureProperty.init(name: "Pinch Gesture", viewColor: .gray, gestureType: pinchGesture)
        let obj4 = GestureProperty.init(name: "Rotation Gesture", viewColor: .green, gestureType: rotationGesture)
        let obj5 = GestureProperty.init(name: "Pan Gesture", viewColor: .blue, gestureType: panGesture)
        let obj6 = GestureProperty.init(name: "Long Press Gesture", viewColor: .systemTeal, gestureType: longPressGesture)
        
        arrObjGesture = [obj1,obj2,obj3,obj4,obj5,obj6]
    }
    
    // Gesture handlers
    @objc func handleTap() {
        print("Tap Gesture Recognized")
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            print("Swiped right!")
            // Perform any action on swipe, e.g., navigate or update the UI
        }
    }
    
    // Method to handle the pinch gesture
    @objc func handlePinch(_ pinchGesture: UIPinchGestureRecognizer) {
        // Change the scale of the view based on the pinch gesture scale
        if let viewToZoom = pinchGesture.view {
            viewToZoom.transform = viewToZoom.transform.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
            // Reset the scale factor to avoid compounding the scaling
            pinchGesture.scale = 1.0
        }
    }
    
    // Method to handle the rotation gesture
    @objc func handleRotation(_ rotationGesture: UIRotationGestureRecognizer) {
        if let viewToRotate = rotationGesture.view {
            // Rotate the view based on the gesture's rotation angle
            viewToRotate.transform = viewToRotate.transform.rotated(by: rotationGesture.rotation)
            
            // Reset the rotation so that it does not compound
            rotationGesture.rotation = 0
        }
    }
    
    // Method to handle the pan gesture
    @objc func handlePan(_ panGesture: UIPanGestureRecognizer) {
        // Get the translation of the gesture (movement)
        let translation = panGesture.translation(in: view)
        
        // Update the position of the view
        if let viewToMove = panGesture.view {
            viewToMove.center = CGPoint(x: viewToMove.center.x + translation.x,
                                        y: viewToMove.center.y + translation.y)
        }
        
        // Reset the translation to zero to avoid compounding movement
        panGesture.setTranslation(.zero, in: view)
        print("Pan Gesture Recognized")
    }
    
    @objc func handleLongPress() {
        print("Long Press Gesture Recognized")
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrObjGesture.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GestureCell",for: indexPath) as! GestureCell
        
        cell.lblName.text = arrObjGesture[indexPath.row].name
        cell.MainView.backgroundColor = arrObjGesture[indexPath.row].viewColor
        
        // Remove previously added gesture recognizers to avoid duplicating them
        cell.MainView.gestureRecognizers?.forEach { cell.MainView.removeGestureRecognizer($0) }
        
        // Add the gesture recognizer for the current cell
        cell.MainView.addGestureRecognizer(arrObjGesture[indexPath.row].gestureType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let size = (collectionView.frame.size.width-20)/2
        let height = (collectionView.frame.size.height-10)/3
        return CGSize(width: size, height: height)
    }
    
}

