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
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]  //used for debugging
        self.sceneView.session.run(configuration)   //initializes configuration environment
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
        let planeScene = SCNScene(named: "art.scnassets/Plane.scn")     //this initializes the plane image
        let planeNode = planeScene?.rootNode.childNode(withName: "plane", recursively: false)       //initializes the node ('withName: "plane"' represents the name of the scenegraph located within the Plane.scn file it titles the object (DOES NOT REPRESENT THE FILE NAME)
        planeNode?.position = SCNVector3(0,0,0.1)       //0, 0, 0 represents the xyz graph origin
        planeNode?.scale = SCNVector3(0.01, 0.01, 0.01)     //down scales the plane by 100
        self.sceneView.scene.rootNode.addChildNode(planeNode!)
    }

    @IBAction func addPlane(_ sender: Any) {        //this is the button caller for 'planez' if the button is clicked this gets called
        self.addPlaneNode()
    }
    
    
}

