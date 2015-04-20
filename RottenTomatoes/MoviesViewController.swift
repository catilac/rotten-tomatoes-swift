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
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        fetchMovies()
    }
    
    func fetchMovies() {
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        let apiKey = "7axwganmenhrsju2wpaxu42s"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + apiKey
        let apiEndpoint = NSURL(string: RottenTomatoesURLString)!
        let request = NSMutableURLRequest(URL: apiEndpoint, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 1)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if error != nil {
                MessagePane.showMessage(self.view, message: error.localizedDescription)
                return
            }
            var errorValue: NSError? = error
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as? NSDictionary {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
            }
        })

    }
    
    func onRefresh() {
        fetchMovies()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        
        let posters = movie["posters"] as! NSDictionary
        cell.posterImage.setPosterImage(posters)
        
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
