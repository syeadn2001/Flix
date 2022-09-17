//
//  MoviesViewController.swift
//  Flix
//
//  Created by Adnaan_Syed on 9/16/22.
//

import UIKit

//These classes allow a View Conroller to interact with a UITableView
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Have to check out (movies is an array of dictionaries???)
    var movies = [[String:Any]]()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: The functions for TableView would not be called if these assignments were not made.
        tableView.dataSource = self
        tableView.delegate = self

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
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
                 
                 
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 
                 //MARK: need to reload the tableview (the below functions) in order to display the imported data
                 self.tableView.reloadData()

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        print("task done")
        task.resume()
        
    }
    
    /* MARK: These functions are necessary for the interaction of TableView and View Controllers, wtf is indexPath?????
     MARK: These functions are only loaded thus far when view is loaded (need to reload table view after data is downloaded)
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: Now want to recycle the cells that were created before (but are no longer shown b/c of screen size) instead of creating hundreds of cells for each new movie. that's why we use reusable cells!!!
        //Also want to connect to our custom MovieCell class.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell //(again unwrapping)
        
        let movie = movies[indexPath.row]
        
        let title = movie["title"] as! String
        
        let sum = movie["overview"] as! String
        

        //MARK: Another example of optional checking with either ! or ?
        cell.titleLabel.text = title
        cell.synopsisLabel.text = sum
        return cell;
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
