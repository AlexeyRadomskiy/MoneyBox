//
//  NewGoalTableViewController.swift
//  MoneyBox
//
//  Created by Alexey on 16.04.2022.
//

import UIKit

class NewGoalTableViewController: UITableViewController {
    
    var goal = Goal(name: "",
                    photo: UIImage(systemName: "square.dashed"),
                    price: "",
                    savings: "",
                    income: "",
                    isFavourite: false,
                    isDone: false)
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var savingsTextField: UITextField!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func textChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Сделать фото", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        let photo = UIAlertAction(title: "Выбрать из галереи", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let photo = photoImage.image ?? nil
        let name = nameTextField.text ?? ""
        let price = priceTextField.text ?? ""
        let savings = savingsTextField.text ?? ""
        let income = incomeTextField.text ?? ""
        
        self.goal = Goal(name: name,
                         photo: photo,
                         price: price,
                         savings: savings,
                         income: income,
                         isFavourite: self.goal.isFavourite,
                         isDone: self.goal.isDone)
    }
}

// MARK: - Private methods
extension NewGoalTableViewController {
    private func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let priceText = priceTextField.text ?? ""
        let savingsText = savingsTextField.text ?? ""
        let incomeText = incomeTextField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !priceText.isEmpty && !savingsText.isEmpty && !incomeText.isEmpty
        if saveButton.isEnabled {
            errorHandling(name: nameText, price: priceText, savings: savingsText, income: incomeText)
        }
    }
    
    private func updateUI() {
        photoImage.image = goal.photo
        nameTextField.text = goal.name
        priceTextField.text = goal.price
        savingsTextField.text = goal.savings
        incomeTextField.text = goal.income
    }
    
    private func errorHandling(name: String, price: String, savings: String, income: String) {
        let price = Int(price) ?? 0
        let savings = Int(savings) ?? 0
        let income = Int(income) ?? 0
        if savings >= price {
            showAlert(title: "Измените накопления", message: "Цена должна быть больше накоплений")
            savingsTextField.text = ""
        }
        if  income == 0 {
            showAlert(title: "Измените доход", message: "Необходимо указать минимальный доход")
            incomeTextField.text = ""
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func didTapOne() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension NewGoalTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        priceTextField.inputAccessoryView = keyboardToolbar
        savingsTextField.inputAccessoryView = keyboardToolbar
        incomeTextField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapOne)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

// MARK: - WorkWithImage
extension NewGoalTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImage.image = info[.editedImage] as? UIImage
        photoImage.contentMode = .scaleAspectFill
        photoImage.clipsToBounds = true
        photoImage.layer.cornerRadius = 24
        dismiss(animated: true)
    }
}
