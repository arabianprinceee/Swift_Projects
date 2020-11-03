//
//  NewPlace_TableViewController.swift
//  FavoritePlacesApp_SwiftBook
//
//  Created by Анас Бен Мустафа on 10/25/20.
//

import UIKit
import RealmSwift

class NewPlace_TableViewController: UITableViewController {

    var currentPlace: Place?
    @IBOutlet weak var ImageOfPlace: UIImageView!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var NameOfPlace: UITextField!
    @IBOutlet weak var LocationOfPlace: UITextField!
    @IBOutlet weak var TypeOfPlace: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        SaveButton.isEnabled = false
        
        // Отслеживает изменения в текстфилде имени заведения
        NameOfPlace.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        SetUpEditScreen()
    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) { // Если тыкнули на ячейку с фотографией
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet) // Создаем экшншит
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in // Создаем алерт экшн для вызова камеры
                self.chooseImagePicker(source: .camera)
            }
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in // Создаем алерт экшн для открытия библиотеки фотографий
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) // Создаем алерт экшн с кнопкой отмены выбора (алерт убирается)
            
            actionSheet.addAction(camera) // Добавляем все экшены в алерт
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true) // Вызываем алерт на экран
        }
        
        else {
            view.endEditing(true);
        }
    }
    
    func savePlace() {
        var image: UIImage?
        
        if ImageOfPlace.image != nil {
            image = ImageOfPlace.image
        }
        else {
            image = UIImage(named: "346-3460840_add-camera-icon-icon-add")
        }
        
        let imageData = image?.pngData()
        
        let newPlace = Place(name: NameOfPlace.text!, location: LocationOfPlace.text, type: TypeOfPlace.text, imageData: imageData)
    
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.nameOfPlace = newPlace.nameOfPlace
                currentPlace?.location = newPlace.location
                currentPlace?.typeOfPlace = newPlace.typeOfPlace
                currentPlace?.imageData = newPlace.imageData
            }
        } else {
            StorageManager.saveObject(newPlace)
        }
    }
    
    @IBAction func CancelButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func SetUpEditScreen() {
        if currentPlace != nil {
            SetUpNavigationBar()
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            ImageOfPlace.image = image
            NameOfPlace.text = currentPlace?.nameOfPlace
            LocationOfPlace.text = currentPlace?.location
            TypeOfPlace.text = currentPlace?.typeOfPlace
        }
    }
    
    private func SetUpNavigationBar() {
        
        // Меняем текст у кнопки возврата в баре
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = currentPlace?.nameOfPlace
        SaveButton.isEnabled = true
    }
    

}

// MARK: Work with images

extension NewPlace_TableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Функция для того, чтобы пользователь мог загружать фотографию (с камеры или из галереи)
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) { // Проверяем доступность источника
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true // Даем пользователю возможность редактировать фото при выборе
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil) // Выводим на экран
        }
    }
    
    // В этом методе мы ставим выбранное/сделанное фото в наш аутлет
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        ImageOfPlace.image = info[.editedImage] as? UIImage // Присваиваем аутлету отредактированную фотографию
        ImageOfPlace.contentMode = .scaleAspectFill
        ImageOfPlace.clipsToBounds = true
        dismiss(animated: true, completion: nil) // Фото выбрано - закрываем галерею/камеру
        
    }
    
}

extension NewPlace_TableViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() { // В этом методе описываем доступность кнопки Save
        if (NameOfPlace.text?.isEmpty == true) {
            SaveButton.isEnabled = false
        } else {
            SaveButton.isEnabled = true
        }
    }
}
