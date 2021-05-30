//
//  PlayerDetailsViewController.swift
//  Football App
//
//  Created by BarisOdabasi on 27.05.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class PlayerDetailsViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet var playerImageView: UIImageView!
    
    //MARK: - Properties
    var playerId = 0
    var nameSurname = ""
    var playerName = ""
    var playerAge = 0
    var playerBirth = ""
    var playerNationality = ""
    var playerHeight = ""
    var playerWeight = ""
    var position = ""
    var playerTeamName = ""
    var rating = ""
    var logo: URL?
    
    var player = [Player]()
    
    var spinner: UIActivityIndicatorView?
    var spinnerContainer: UIView?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cim")!)
        playerResponse()
        
    }
    
    //MARK: - Function
    
    func playerResponse() {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "6032d3b765msh84dc4e05a81515bp18eafdjsn9a34429b3475",
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com"
        ]
            showIndicator()
        AF.request("https://api-football-v1.p.rapidapi.com/v2/players/player/\(playerId)", headers: headers).response { [self] response in
            self.hideIndicator()
            debugPrint(response)
            switch response.result {
            case .success(let jsonResult):
                print("premierLeagueButton Response : \(jsonResult!)")
                do{
                    let football = try JSONDecoder().decode(PlayerResponse.self, from: try JSON(jsonResult!).rawData())
                        player.append(contentsOf: football.api.players)
                        uiView()
                 } catch let error{
                    print("premierLeagueButton Json Parse Error : \(error)")
                }
            case .failure(let error):
                print("premierLeagueButton Request failed with error: \(error)")
            }
        }
    }
   
    
    func uiView() {
        nameSurnameLabel.text? = nameSurname
        nameLabel.text? = playerName
        ageLabel.text? = String(playerAge)
        birthLabel.text? = String(playerBirth)
        nationalityLabel.text? = playerNationality
        heightLabel.text? = playerHeight
        positionLabel.text? = position
        teamNameLabel.text? = playerTeamName
        weightLabel.text? = playerWeight
        if logo != nil {
            playerImageView?.kf.setImage(with: URL?(logo!))
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
    

}
