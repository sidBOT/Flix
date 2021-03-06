//
//  DetailViewController.swift
//  Flix
//
//  Created by siddhant on 1/15/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let releaseDate = "release_date"
    static let overview = "overview"
    static let backdroppath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var backImageView: UIImageView!

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    //var movie: [String: Any]?
     var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie.title
            releaseDateLabel.text =  movie.relDate
            overviewLabel.text = movie.overview
            
            let backDropURL = movie.backdropUrl
            backImageView.af_setImage(withURL: backDropURL!)
            let posterPathURL = movie.posterUrl
            posterImageView.af_setImage(withURL: posterPathURL!)
            
        
            
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
