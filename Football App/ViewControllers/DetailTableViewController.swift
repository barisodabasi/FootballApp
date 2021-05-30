//
//  DetailTableViewController.swift
//  Football App
//
//  Created by BarisOdabasi on 24.05.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DetailTableViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    var team = [Teams]()
    
    var leagueId = 0
    
    var spinner: UIActivityIndicatorView?
    var spinnerContainer: UIView?
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "cim")!)
        
        response()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamDetail" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedTeam = team[selectedIndexPath!.row]
            let navigationController = segue.destination as! TeamDetailsViewController
            navigationController.id = selectedTeam.teamId
            navigationController.teamName = (selectedTeam.name!)
            navigationController.stadiumName = (selectedTeam.stadiumName!)
            navigationController.capacity = (selectedTeam.stadiumCapacity!)
            navigationController.founded = (selectedTeam.founded!)
            navigationController.logo = (selectedTeam.logo)
        }
    }
    
    
    //MARK: - Functions
    func response() {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "6032d3b765msh84dc4e05a81515bp18eafdjsn9a34429b3475",
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com"
        ]
            showIndicator()
        AF.request("https://api-football-v1.p.rapidapi.com/v2/teams/league/\(leagueId)", headers: headers).response { [self] response in
            self.hideIndicator()
            debugPrint(response)
            switch response.result {
            case .success(let jsonResult):
                print("premierLeagueButton Response : \(jsonResult!)")
                do{
                    let football = try JSONDecoder().decode(FootballAppResponse.self, from: try JSON(jsonResult!).rawData())
                    team.append(contentsOf: football.api.teams)
                    
                    debugPrint("football:  \(football)")
                    self.tableView.reloadData()
                } catch let error{
                    print("premierLeagueButton Json Parse Error : \(error)")
                }
            case .failure(let error):
                print("premierLeagueButton Request failed with error: \(error)")
                
            }
        }
    }
    
    func showIndicator(){
        spinnerContainer = UIView.init(frame: self.view.frame)
        spinnerContainer!.center = self.view.center
        spinnerContainer!.backgroundColor = .init(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        self.view.addSubview(spinnerContainer!)
        
        spinner = UIActivityIndicatorView.init(style: .large)
        spinner!.center = spinnerContainer!.center
        spinnerContainer!.addSubview(spinner!)
        
        spinner!.startAnimating()
    }
    
    func hideIndicator(){
        spinner?.removeFromSuperview()
        spinnerContainer?.removeFromSuperview()
    }
}

//MARK: - TableView DataSource and Delegate
extension DetailTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        cell.teamNameLabel.text = self.team[indexPath.row].name
        cell.subscribeNameLabel.text = self.team[indexPath.row].code
        cell.imageViewCell.kf.setImage(with: URL?(self.team[indexPath.row].logo!))
        //.image = UIImage(named: "logo")
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "teamDetail", sender: nil)
    }
    
}

