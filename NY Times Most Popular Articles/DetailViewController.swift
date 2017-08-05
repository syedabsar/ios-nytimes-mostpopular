//
//  DetailViewController.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    var detailItem: Results?

    func configureView() {
        // Update the user interface for the detail item.
        if detailItem != nil {

            self.abstractLabel.text = detailItem?.abstract
            self.sectionLabel.text = detailItem?.section
            self.titleLabel.text = detailItem?.title
            self.byLineLabel.text = detailItem?.byline
            self.publishDateLabel.text = detailItem?.published_date
        }
    }

    @IBAction func didTapDetailsButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

