//
//  CustomFloatingTextField.swift
//  FloatingTextField
//
//  Created by Apple on 02/10/24.
//
import UIKit
@IBDesignable
class FloatingTextFieldView: UIView {
    
    // IBInspectable properties to customize the view
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            containerView.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            containerView.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            containerView.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var placeholder: String = "Enter Text" {
        didSet {
            floatingLabel.text = placeholder
        }
    }
    
    // Floating label for the text field
    private let floatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Container for the floating label
    private let labelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white // Optional: Match your view's background
        return view
    }()
    
    // Container for the text field
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0.0
        return view
    }()
    
    // The actual text field
    private let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Initializer for programmatic usage
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // Initializer for storyboard/XIB usage
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Set up the view hierarchy and constraints
    private func setupView() {
        // Add containerView to the main view first (this ensures it's behind the labelContainer)
        addSubview(containerView)
        
        // Then add the labelContainer (it will appear above containerView)
        addSubview(labelContainer)
        
        // Add the floating label inside the label container
        labelContainer.addSubview(floatingLabel)
        
        // Add the text field inside the container
        containerView.addSubview(textField)
        
        // Set the initial label text
        floatingLabel.text = placeholder
        
        // Set up constraints for the label container
        NSLayoutConstraint.activate([
            labelContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10), // Start below the labelContainer
            labelContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            labelContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        // Set up constraints for the floating label
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 5),
            floatingLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: -5),
            floatingLabel.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor)
        ])
        
        // Set up constraints for the container view
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0), // Start below the labelContainer
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        // Set up constraints for the text field
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        // Set up text field events
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        // Set the delegate for the text field
        textField.delegate = self
    }
    
    
    // IBAction to dynamically update border properties
    @IBAction func updateBorderColorAndWidth(newColor: UIColor, newWidth: CGFloat) {
        containerView.layer.borderColor = newColor.cgColor
        containerView.layer.borderWidth = newWidth
    }
    
    // Event when editing begins
    @objc private func textFieldDidBeginEditing() {
        animateLabelContainer(up: true)
    }
    
    // Event when editing ends
    @objc private func textFieldDidEndEditing() {
        if textField.text?.isEmpty ?? true {
            animateLabelContainer(up: false)
        }
    }
    
    // Animate the label container up or down
    private func animateLabelContainer(up: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if up {
                self.labelContainer.transform = CGAffineTransform(translationX: 0, y: -25)
                self.floatingLabel.font = UIFont.systemFont(ofSize: 14)
                self.floatingLabel.textColor = self.borderColor
            } else {
                self.labelContainer.transform = CGAffineTransform.identity
                self.floatingLabel.font = UIFont.systemFont(ofSize: 16)
                self.floatingLabel.textColor = UIColor.lightGray
            }
        })
    }
}

extension FloatingTextFieldView: UITextFieldDelegate {
    // UITextFieldDelegate method to handle the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

