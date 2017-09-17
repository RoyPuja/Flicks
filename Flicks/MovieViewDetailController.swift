//
//  MovieViewDetailController.swift
//  Flicks
//
//  Created by Roy, Puja on 9/17/17.
//  Copyright © 2017 Roy, Puja. All rights reserved.
//

import UIKit

class MovieViewDetailController: UIViewController {

    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie :NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie["title"] as? String
        titleLabel.text=title
        let overview=movie["overview"] as! String
        overviewLabel.text=overview
        let base_url="https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String {
            
            let imageUrl = URL(string: base_url + posterPath)
            
            posterImageView.setImageWith(imageUrl!)
        }



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
       // let indexPath = tableview
        
    }
    

}
