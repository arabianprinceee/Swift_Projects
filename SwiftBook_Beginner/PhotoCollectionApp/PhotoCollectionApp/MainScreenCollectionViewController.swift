//
//  MainScreenCollectionViewController.swift
//  PhotoCollectionApp
//
//  Created by Анас Бен Мустафа on 05.09.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class PhotoCollectionViewController : UICollectionViewController {
    
//  var selectedImage: UIImage
    var imagePicker = UIImagePickerController()
//    var photos = ["Animal1", "Animal2", "Animal3", "Animal4", "Animal5", "Animal6", "Animal7", "Animal8", "Animal9", "Animal10", "Animal11", "Animal12", "Animal13", "Animal14", "Animal15"]
    var photos = [UIImage]()
    
    // Функция, добавляющая в массив новую фотку
    private func addPhotoCell(image: UIImage) {
        photos.append(image)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "TappedPhotoSegue" else { return }
        
        let DestinationVC = segue.destination as! DetailPhotoViewController
        let cell = sender as! PhotoCell
        DestinationVC.image = cell.AnimalImageView.image
        
    }
    
    // Функционал кнопки добавления фотографии в коллекцию из галереи
    @IBAction func AddPhotoAction(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true // Разрешаем пользователю редактирование
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Кнопка удаления элементов из коллекции
    @IBAction func ClearAllButton(_ sender: UIBarButtonItem) {
        /*
        if (photos.count > 0) {
        var indexPath = IndexPath(item: self.photos.count - 1, section: 0)
        for i in 0...photos.count - 1 {
            indexPath = IndexPath(item: self.photos.count - 1 - i, section: 0)
            collectionView?.performBatchUpdates({ self.collectionView?.deleteItems(at: [indexPath]) }, completion: nil)
            }
        }
        
        photos.removeAll()
        */
        photos = []
        collectionView.reloadData()
    }
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let image = photos[indexPath.item]
        cell.AnimalImageView.image = image
        
        //let image = UIImage(named: photos[indexPath.item]) // Создаем объект фото по названию из массива
        //cell.AnimalImageView.image = image
        
        return cell
    }
}

// Расширение, отвечающее за расположение элементов в ColloctionView
extension PhotoCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    // Отвечает за размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2 // Количество объектов на одной строке
        let paddingWidth = 20 * (itemsPerRow + 1) // Это общая ширина всех отступов в одной строке (между элементами) + слева и справа
        let availibleWidth = collectionView.frame.width - paddingWidth // Из общей ширины экрана вычли ширину всех отступов
        let itemWidth = availibleWidth / itemsPerRow
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // Отвечает за настройку отступов от правой/левой/верхней/нижней границ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // Отвечает за расстояние между строками в коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // Отвечает за расстояние между элементами в коллекции
    //func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    // return 20
    //}
}

// Расширение для сохраненния выбранной из галереи фотографии
extension PhotoCollectionViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Действия после того, как была выбрана фотография
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage // Создали объект из отредактированного изображения
        addPhotoCell(image: image) // Добавил фотографию в массив
        
        // Обновляем таблицу с добавленной фотографией
        let indexPath = IndexPath(item: self.photos.count - 1, section: 0)
        collectionView?.performBatchUpdates({ self.collectionView?.insertItems(at: [indexPath]) }, completion: nil)
        
        // Убираем экран с добавлением фотографии
        dismiss(animated: true, completion: nil)
    }
    
}
