//
//  ViewController.swift
//  template-swift-no-sb
//
//  Created by Glenn Adams on 7/30/22.
// A Swift project template for UIKit apps, no storyboards
// 3 horizontal stripes, but remove middle after 5 seconds

import UIKit

class RootViewController: UIViewController {

    var v2:UIView!
    var constraintsWith = [NSLayoutConstraint]()
    var constraintsWithout = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        let v1 = UIView()
        v1.backgroundColor = .red
        v1.translatesAutoresizingMaskIntoConstraints = false
        
        let v2 = UIView()
        v2.backgroundColor = .yellow
        v2.translatesAutoresizingMaskIntoConstraints=false
        self.v2 = v2
        
        
        let v3 = UIView()
        v3.backgroundColor = .green
        v3.translatesAutoresizingMaskIntoConstraints=false
        
        self.view.addSubview(v1)
        self.view.addSubview(v2)
        self.view.addSubview(v3)
        
        // 3 horizontal stripes v1,v2,v3
        let topStripeHor = NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-(20)-[v(100)]", metrics: nil, views: ["v":v1])
        let middleStripeHor = NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-(20)-[v(100)]", metrics: nil, views: ["v":v2])
        let bottomStripeHor = NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-(20)-[v(100)]", metrics: nil, views: ["v":v3])

        // first stripe 100 from top
        let topStripeVert = NSLayoutConstraint.constraints(withVisualFormat:
            "V:|-(600)-[v(20)]", metrics: nil, views: ["v":v1])
        // vertial with all 3 : 2,3,4, below v1
        let middleAndBotVert = NSLayoutConstraint.constraints(withVisualFormat:
            "V:[v1]-(20)-[v2(20)]-(20)-[v3(20)]", metrics: nil,
            views: ["v1":v1, "v2":v2, "v3":v3])
        // vertical for top and bottom only
        let bottomVert = NSLayoutConstraint.constraints(withVisualFormat:
            "V:[v1]-(20)-[v3(20)]", metrics: nil, views: ["v1":v1, "v3":v3])

        NSLayoutConstraint.activate([topStripeHor,bottomStripeHor,topStripeVert].flatMap{$0})
        
        // top and bottom horizontal stripes
        self.constraintsWith.append(contentsOf: middleStripeHor) // middle bar horiz
        // vertical 1,2, and 3
        self.constraintsWith.append(contentsOf: middleAndBotVert) // 3 horiz stripes vertially
        // activate 3 stripes
        NSLayoutConstraint.activate(self.constraintsWith)
        // vertical for 1 and 3 only
        self.constraintsWithout.append(contentsOf: bottomVert)
        
        Task {
            try await Task.sleep(nanoseconds: 5000000000)
            print("remove middle constraints ")
            //MUST REVMOVE MIDDLE VIEW FROM SUPERVIEW
            self.v2.removeFromSuperview()
            // DEACTIVATE THE ALL3 CONTRACTS, ACTIVATE THE "ONLY 2" STRIPES
            NSLayoutConstraint.deactivate(self.constraintsWith)
            NSLayoutConstraint.activate(self.constraintsWithout)

        }
        
        Task {
            try await Task.sleep(nanoseconds: 10000000000)
            self.view.addSubview(v2 ) // add the middle stripe
            NSLayoutConstraint.deactivate(constraintsWithout)
            NSLayoutConstraint.activate(constraintsWith)
        }
    }
}

