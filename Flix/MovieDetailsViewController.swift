//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Adnaan_Syed on 9/28/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    //Setting up a variable for a movie (will get data from previous TableView
    var movie : [String:Any]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Have to type cast to String b/c originally just undetermined JSON
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        //To automatically fix text wrapping, should use auto-layout. Otherwise, do this:
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        
        
        //MARK: Movie Poster then Movie Backdrop
        //complicated path due to MovieDatabase API
        //When working with URLs, must caste strings representign URLs to an actual URL type (will validate whether the string is a valid URL or not)
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:baseUrl+posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string:"https://image.tmdb.org/t/p/w780"+backdropPath)
        backdropView.af.setImage(withURL: backdropUrl!)
        
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
