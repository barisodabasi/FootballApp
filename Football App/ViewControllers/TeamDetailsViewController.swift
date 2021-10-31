//
//  TeamDetailsViewController.swift
//  Football App
//
//  Created by BarisOdabasi on 25.05.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class TeamDetailsViewController: UIViewController {

    //MARK: - UI Elements
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var stadiumNameLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    var team = [Teams]()
    var player = [Player]()
    
    var id: Int = 0
    var teamName: String = ""
    var stadiumName: String = ""
    var capacity: Int = 0
    var founded: Int = 0
    var logo: URL?
    
    var spinner: UIActivityIndicatorView?
    var spinnerContainer: UIView?
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cim")!)
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "cim")!)
        firstView.alpha = 1
        secondView.alpha = 0
        response()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerDetail" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedPlayer = player[selectedIndexPath!.row]
            let navigationController = segue.destination as! PlayerDetailsViewController
            navigationController.playerId = selectedPlayer.playerId!
            navigationController.nameSurname = selectedPlayer.playerName ?? "Not Found !"
            navigationController.playerAge = selectedPlayer.age!
            navigationController.playerBirth = selectedPlayer.birthDate ?? "Not Found !"
            navigationController.playerHeight = selectedPlayer.height ?? "Not Found !"
            navigationController.playerName = selectedPlayer.playerName ?? "Not Found !"
            navigationController.playerNationality = selectedPlayer.nationality ?? "Not Found !"
            navigationController.playerTeamName = selectedPlayer.teamName ?? "Not Found !"
            navigationController.playerWeight = selectedPlayer.weight ?? "Not Found !"
            navigationController.position = selectedPlayer.position ?? "Not Found !"
            navigationController.playerNationality = selectedPlayer.nationality ?? "Not Found !"
            navigationController.logo = logo
        }
    }
    
    //MARK: - Functions
    
    func response() {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "YOUR_API_KEY !!!!!",
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com"
        ]
        showIndicator()
        AF.request("https://api-football-v1.p.rapidapi.com/v2/teams/team/\(id)", headers: headers).response { [self] response in
            self.hideIndicator()
            debugPrint(response)
            switch response.result {
            case .success(let jsonResult):
                print("premierLeagueButton Response : \(jsonResult!)")
                do{
                    let football = try JSONDecoder().decode(FootballAppResponse.self, from: try JSON(jsonResult!).rawData())
                        team.append(contentsOf: football.api.teams)
                        uiView()
                 } catch let error{
                    print("premierLeagueButton Json Parse Error : \(error)")
                }
            case .failure(let error):
                print("premierLeagueButton Request failed with error: \(error)")
            }
        }
    }
    
    func playerResponse() {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "YOUR_API_KEY !!!!!",
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com"
        ]
                showIndicator()
        AF.request("https://api-football-v1.p.rapidapi.com/v2/players/team/\(id)/2020", headers: headers).response { [self] response in
            self.hideIndicator()
            debugPrint(response)
            switch response.result {
            case .success(let jsonResult):
                print("premierLeagueButton Response : \(jsonResult!)")
                do{
                    let football = try JSONDecoder().decode(PlayerResponse.self, from: try JSON(jsonResult!).rawData())
                        player.append(contentsOf: football.api.players)
                        tableView.reloadData()
                 } catch let error{
                    print("premierLeagueButton Json Parse Error : \(error)")
                }
            case .failure(let error):
                print("premierLeagueButton Request failed with error: \(error)")
            }
        }
    }
    
    func uiView() {
            teamNameLabel?.text = teamName
            stadiumNameLabel?.text = stadiumName
            capacityLabel?.text = String(capacity)
            foundedLabel?.text = String(founded)
        if logo != nil {
            teamImageView?.kf.setImage(with: URL?(logo!))
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
            
    //MARK: - Actions

    @IBAction func indexChanced(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
            
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
            playerResponse()
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.player.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        cell.playerNameLabel.text = self.player[indexPath.row].playerName
        cell.positionLabel.text = self.player[indexPath.row].position
        cell.playerImageView?.kf.setImage(with: URL?(logo!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "playerDetail", sender: nil)
    }
    
}
