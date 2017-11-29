//
//  ViewController.swift
//  plane shooter game
//
//  Created by James Lee on 11/28/17.
//  Copyright © 2017 James Lee. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(  sender: Any) {
        self.addPlaneNode()
    }

    func addPlaneNode() {
        //let planeScene = SCNScene(named: ")
        let planeScene = SCNScene(named: "art.scnassets/Plane.scn")
        let planeNode = planeScene?.rootNode.childNode(withName: "plane", recursively: false)
        planeNode?.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(planeNode!)
    }

    @IBAction func addPlane(_ sender: Any) {
        addPlaneNode()
    }
    
    
}

