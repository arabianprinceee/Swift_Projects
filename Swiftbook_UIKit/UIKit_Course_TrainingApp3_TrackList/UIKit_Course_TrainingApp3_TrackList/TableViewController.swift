//
//  TableViewController.swift
//  UIKit_Course_TrainingApp3_TrackList
//
//  Created by Анас Бен Мустафа on 22.09.2020.
//

import UIKit

class TableViewController: UITableViewController {

    let TrackList = ["Zayn – PillowTalk (2017)",
                     "Dua Lipa – Physical (2020)",
                     "The Weeknd – After Hours (2020)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrackList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)

        cell.imageView?.image = image(UIImage(named: TrackList[indexPath.row])!, withSize: CGSize(width: 90, height: 70 ))
        cell.textLabel?.text = TrackList[indexPath.row]
        cell.textLabel?.numberOfLines = 2
        
        return cell
    }
    
    func image( _ image: UIImage, withSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSongInfo" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailsVC = segue.destination as! DetailViewController
                detailsVC.trackTitle = self.TrackList[indexPath.row]
            }
        }
    }

}
