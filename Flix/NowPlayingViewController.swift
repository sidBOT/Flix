//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by siddhant on 1/14/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    
    //var movies: [[String:Any]] = []
    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRequest(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()

    }
    
    func didPullToRequest(_ refreshControl: UIRefreshControl) {
        activityIndicator.startAnimating()
        fetchMovies()
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
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = []
                for dictionary in movieDictionaries {
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for:indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie.title
        let overview = movie.overview
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
    
        let posterURL = movie.posterUrl
        cell.photoView.af_setImage(withURL: posterURL!)
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MovieCell
        if let indexPath = tableView.indexPath(for: cell){
            let abcd = movies [indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = abcd
            
            
        }
    }
    


}
