//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Adnaan_Syed on 9/28/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //UICollectionView: Display one or more subviews in a highly configurable arrangement.
    @IBOutlet weak var collectionView: UICollectionView!
    
    var superHeroMovies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //MARK: changing the grid system into other UI systems
        //The specific layout of CollectionView will now be a flow layout(organizes items into a grid with optional headers & footers)???
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //Setting the minimum vertical and horizontal distance between each cell
        //if you specify the width based off the size of the view's frame, then cannot have any interitem spacing b/c that is a variable that's unaccounted for
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        //obtaining the view, then the specific frame of it, then the dimensions (size) of it, then the width
            //now also accoutning for the minimuminteritemspacing
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2) / 3
        //getting the item size of a specfici cell, and setting it to the proper dimensions through CGSize object
        layout.itemSize = CGSize(width: width, height: width*3/2)
        
        
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        /*
         MARK: Ignoring this part FOR NOW; Downloads a list of movies, along with other info, and then stores the list into an array of dics
         */
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 //MARK: what is casting (w/ exclamations?) & forced unwrapping???
                 self.superHeroMovies = dataDictionary["results"] as! [[String:Any]]
                 
                 self.collectionView.reloadData()

             }
        }
        print("task done")
        task.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeroMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let superHeroMovie = superHeroMovies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = superHeroMovie["poster_path"] as! String
        let posterUrl = URL(string:baseUrl+posterPath)
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        
        return cell
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
