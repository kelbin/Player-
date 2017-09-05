//
//  MusicGenreListSubViewController.swift
//  Player
//
//  Created by Келбин on 17.08.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit

class MusicGenreListSubViewController: UITableViewController {
    var musicList: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = musicList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.setToolbarHidden(false, animated: true)
        let nameBarButton = UIBarButtonItem()
        let urlBarButton = UIBarButtonItem()
        nameBarButton.title = musicList[indexPath.row].name
        //urlBarButton.title = musicList[indexPath.row].url
        //urlBarButton.image = picture.image
        //let image = UIImage(named: "Default-568h@2x.png")
        preparationBarButton(nameBarButton: nameBarButton, urlBarButton: urlBarButton, imageUrl: musicList[indexPath.row].picture)
    }
    
    private func preparationBarButton(nameBarButton:UIBarButtonItem, urlBarButton:UIBarButtonItem, imageUrl: String)  {
        nameBarButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black, NSFontAttributeName:UIFont.boldSystemFont(ofSize: 10)], for: .normal)
        nameBarButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black, NSFontAttributeName:UIFont.boldSystemFont(ofSize: 10)], for: .disabled)
        //print(picture.image as Any)
        //urlBarButton.setBackgroundImage(picture.image, for: .normal, style: .plain, barMetrics: .default)
        nameBarButton.isEnabled = false
        urlBarButton.isEnabled = false
        let items: [UIBarButtonItem] = [nameBarButton,urlBarButton]
        self.navigationController?.toolbar.setItems(items, animated: true)
    }
    
       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
