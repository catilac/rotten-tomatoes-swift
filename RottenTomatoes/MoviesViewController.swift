//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Chirag Davé on 4/15/15.
//  Copyright (c) 2015 Chirag Davé. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let apiKey = "7axwganmenhrsju2wpaxu42s"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + apiKey
        let apiEndpoint = NSURL(string: RottenTomatoesURLString)!
        let request = NSMutableURLRequest(URL: apiEndpoint)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as? NSDictionary {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
            }
        })
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        let imageURL = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        cell.posterImage.setImageWithURL(imageURL)
        
        return cell
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MovieCell
        let indexPath = tableView.indexPathForCell(cell)!
        let movie = movies![indexPath.row]
        
        var detailViewController = segue.destinationViewController as! MovieDetailViewController
        detailViewController.movie = movie
    }

}
