//
//  ViewController.swift
//  AnimationDemo
//
//  Created by mac on 13/09/24.
//

/// Types of  Animation
/*
 1. UIView Animations (UIKit)
    UIKit provides simple methods to animate view properties, such as:

    - Position (frame, center)
    - Size (bounds)
    - Opacity (alpha)
    - Background color (backgroundColor)
    - Transformations (transform for scaling, rotating, etc.)
 
    Common methods include:
        - UIView.animate(withDuration:animations:)
        - UIView.animate(withDuration:animations:completion:)
 
    Example:
        UIView.animate(withDuration: 1.0) {
        self.view.alpha = 0.0
        }
 
 2. Keyframe Animations (UIKit): Defines multiple stages of an animation over time using keyframes.
 
 3. Layer Animations (Core Animation): Provides explicit and implicit animations for CALayer properties such as position, opacity, and bounds.
 
 4. Spring Animations (UIKit): Creates a bouncy or elastic effect using damping and initial velocity.

 5. Transition Animations (UIView): Animates transitions between two views or view states, like fading or flipping.
 
 6. Group Animations (CAAnimationGroup): Combines multiple animations into one seamless animation group using CAAnimationGroup.
 
 7. 3D Animations (CATransform3D): Animates views or layers in 3D space using CATransform3D for rotating, scaling, or translating.
 
 8. Shape Layer Animations: Animates path-related properties of CAShapeLayer, such as stroke and fill.
 
 9. Constraint Animations (Auto Layout): Animates changes in Auto Layout constraints for dynamic layout updates.
    Example:
        self.constraint.constant = 200
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
 */

/// This is inbuilt animation function with 7 arguments
/*
    1. animation Duration :- how much time does it take to animate the view
    2. delay :- how much delay you want before starting animation
    3. damping Ratio :- it lies between 0 to 1 if the damping ratio is 1 then the view will smoothly settles to its final position when the damping ratio is less than 1 it will oscillate more and more before settling to its final position.
    4. inital spring velocity :- initial velocity of the view before the start of the animation
    5. options :- one of the UIViewAnimationOptions example CureveEaseIn or CurveEaseOut
    6. animation :- it accepts an animation block which contains the code for animation
 */

/*
     Use setNeedsLayout() when you want the layout to update in the next cycle.
     Use layoutIfNeeded() when you want to immediately update the layout.
     Use layoutSubviews() when implementing custom layout logic in a view subclass.
 */
import UIKit

class ViewController: UIViewController {
   
    @IBOutlet var viewFirst: UIView!
    @IBOutlet var btnFirst: UIButton!
    
    @IBOutlet var viewSecond: UIView!
    @IBOutlet var btnSecond: UIButton!
    
    @IBOutlet var viewThird: UIView!
    @IBOutlet var btnThird: UIButton!
    
    @IBOutlet var viewFourth: UIView!
    @IBOutlet var btnFourth: UIButton!
    
    @IBOutlet var btnFifth: UIButton!
    @IBOutlet var viewFifth: UIView!
    
    @IBOutlet var viewSixth: UIView!
    @IBOutlet var btnSixth: UIButton!
    
    @IBOutlet var btnShow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFirstAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            
            self.viewFirst.isHidden = true
        }
    }
    @IBAction func btnSecondAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
         
            self.viewSecond.isHidden = true
        }
    }
    
    @IBAction func btnThirdAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
          
            self.viewThird.isHidden = true
        }
    }
    
    @IBAction func btnFourthAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
          
            self.viewFourth.isHidden = true
        }
    }
    
    @IBAction func btnFifthAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
       
            self.viewFifth.isHidden = true
        }
    }
    
    @IBAction func btnSixthAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            
            self.viewSixth.isHidden = true
        }
    }
   
    @IBAction func btnShowAllAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            
            self.viewFirst.isHidden = false
            self.viewSecond.isHidden = false
            self.viewThird.isHidden = false
            self.viewFourth.isHidden = false
            self.viewFifth.isHidden = false
            self.viewSixth.isHidden = false
        }
    }
}

