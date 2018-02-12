//
//  SuperheroViewController.swift
//  Flix
//
//  Created by siddhant on 1/17/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
   var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumLineSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width*3/2)
        
        

        
        fetchMovies()

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        let posterURL = movie.posterUrl
        cell.posterImage.af_setImage(withURL: posterURL!)
            

        return cell
        
    }
    
    

    func fetchMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                let alerController = UIAlertController(title: "Error", message: "Not connected to any network", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    
                })
                let okButton = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    
                })
                alerController.addAction(cancelButton)
                alerController.addAction(okButton)
                self.present(alerController, animated: true) {
                }
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
                let mymovies = dataDictionary["results"] as! [[String:Any]]
                
                self.movies = []
                for dictionary in mymovies {
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                }
                
                // Stop the activity indicator
                // Hides automatically if "Hides When Stopped" is enabled
                
                self.collectionView.reloadData();
                
            }
        }
        task.resume()
    }


}
