//
//  HomeViewController.swift
//  Football App
//
//  Created by BarisOdabasi on 21.05.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var premierLeagueButton: UIButton!
    @IBOutlet weak var spainLeagueButton: UIButton!
    @IBOutlet weak var bundesligaButton: UIButton!
    @IBOutlet weak var serieaButton: UIButton!
    @IBOutlet weak var league1Button: UIButton!
    @IBOutlet weak var sporTotoButton: UIButton!
    @IBOutlet weak var hollandButton: UIButton!
    @IBOutlet weak var belgiumButton: UIButton!
    
    
    var leagueId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cim")!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let navigationController = segue.destination as! DetailTableViewController
            navigationController.leagueId = leagueId
        }
    }

    @IBAction func leagueButton(_ buton: UIButton) {
        switch buton {
        case premierLeagueButton:
            leagueId = 2
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case spainLeagueButton:
            leagueId = 87
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case bundesligaButton:
            leagueId = 8
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case serieaButton:
            leagueId = 94
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case league1Button:
            leagueId = 4
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case sporTotoButton:
            leagueId = 114
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case hollandButton:
            leagueId = 10
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        case belgiumButton:
            leagueId = 34
            performSegue(withIdentifier: "toDetailVC", sender: nil)
        default:
            break
        }
    }
}
