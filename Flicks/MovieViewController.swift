//
//  MovieViewController.swift
//  Flicks
//
//  Created by Roy, Puja on 9/17/17.
//  Copyright © 2017 Roy, Puja. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var movies : [NSDictionary]?
    
    @IBOutlet weak var networkError: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource=self
        tableView.delegate=self
        //MBProgressHUD.hide(for: self.view, animated: true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
                getMovieData()
        networkError.isHidden=true
    }

    func getMovieData(){
        
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
    let request = URLRequest(url: url!)
    let session = URLSession(
    configuration: URLSessionConfiguration.default,
    delegate:nil,
    delegateQueue:OperationQueue.main
    )
    
    let task : URLSessionDataTask = session.dataTask(
    with: request as URLRequest,
    completionHandler: { (data, response, error) in
    MBProgressHUD.hide(for: self.view, animated: true)
    
    if let data = data {
   // if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
        let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    //print("responseDictionary: \(responseDictionary)")
    
    // Recall there are two fields in the response dictionary, 'meta' and 'response'.
    // This is how we get the 'response' field
    self.movies=responseDictionary["results"] as! [NSDictionary]
    
    self.tableView.reloadData()
        self.networkError.isHidden=true
        }
    else if (error != nil) {
        // Show the network error view
        self.networkError.isHidden = false;
        //onDataLoad();
        }
    // This is where you will store the returned array of posts in your posts property
    // self.feeds = responseFieldDictionary["posts"] as! [NSDictionary]
    
        
    });
    task.resume()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count
        }
        else{
            return 0
        }
        
}
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie=movies![indexPath.row]
        let title=movie["title"] as! String
        let overview=movie["overview"] as! String
        let base_url="https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String {
            
            let imageUrl = URL(string: base_url + posterPath)
            
            cell.posterView.setImageWith(imageUrl!)
                    }
        
        
        cell.titleLabel.text=title
        cell.overviewLabel.text=overview
        
            return cell
        
        
        
        
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getMovieData()
            
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let movieDetailViewController = segue.destination as! MovieViewDetailController
        movieDetailViewController.movie = movie;
    }
    

}
