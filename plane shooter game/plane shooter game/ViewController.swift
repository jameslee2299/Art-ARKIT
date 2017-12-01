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
    var timer: Timer?
    var forward = false
    var up = false
    var left = false
    var right = false
    var down = false
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
    
    @objc func actionTimer() {
        if up || left || right || down || forward {
            if right {
                self.sceneView.scene.rootNode.childNode(withName: "plane", recursively:true)?.rotation = SCNVector4(0, 1, 0, 2)
                //tempPlane?.rotation = SCNVector4(0, 1, 0, 2)
            }
        }
    }
    
    func addPlaneNode() {
        let planeScene = SCNScene(named: "art.scnassets/Plane.scn")     //this initializes the plane image
        let planeNode = planeScene?.rootNode.childNode(withName: "plane", recursively: false)       //initializes the node ('withName: "plane"' represents the name of the scenegraph located within the Plane.scn file it titles the object (DOES NOT REPRESENT THE FILE NAME)
        planeNode?.position = SCNVector3(0, 0.3, 0)       //0, 0, 0 represents the xyz graph origin
        planeNode?.scale = SCNVector3(0.01, 0.01, 0.01)     //down scales the plane by 100
        self.sceneView.scene.rootNode.addChildNode(planeNode!)
        timer = Timer.scheduledTimer(timeInterval: 0.017, target: self, selector: #selector(ViewController.actionTimer), userInfo: nil, repeats: true)
    }
    
    func addAlienNode() {
        let alienScene = SCNScene(named: "art.scnassets/alien.scn")
        let alienNode = alienScene?.rootNode.childNode(withName: "alien", recursively: false)
        alienNode?.position = SCNVector3(self.randomLocationGenerator(firstNum: -4,secondNum: 4),
                                         self.randomLocationGenerator(firstNum: -4,secondNum: 4),
                                         self.randomLocationGenerator(firstNum: -4,secondNum: 4))
        alienNode?.scale = SCNVector3(0.01, 0.01, 0.01)
        self.sceneView.scene.rootNode.addChildNode(alienNode!)
    }

    //timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "rapidFire", userInfo: nil, repeats: true)

    //var tempNode = self.sceneView.scene.rootNode.childNode(withName: "plane", recursively:true)
    //this actually gets the plane within the scope
    
    @IBAction func upButtonDown(_ sender: Any) {
        up = true
    }
    @IBAction func upButtonUp(_ sender: Any) {
        up = false
    }

    
    @IBAction func rightButtonDown(_ sender: Any) {
        right = true
    }
    @IBAction func rightButtonUp(_ sender: Any) {
        right = false
    }

    @IBAction func downButtonDown(_ sender: Any) {
        down = true
    }
    @IBAction func downButtonUp(_ sender: Any) {
        down = false
    }

    
    @IBAction func leftButtonDown(_ sender: Any) {
        left = true
    }
    @IBAction func leftButtonUp(_ sender: Any) {
        left = false
    }

    
    @IBAction func planeForwardButtonDown(_ sender: Any) {
        forward = true
    }
    @IBAction func planeForwardButtonUp(_ sender: Any) {
        forward = false
    }
    
    
    @IBAction func addAlien(_ sender: Any) {    //called if 'alienz' button is clicked
        self.addAlienNode()
    }
    
    @IBAction func addPlane(_ sender: Any) {        //called if 'planez' button is clicked
        self.addPlaneNode()
    }
    
    func randomLocationGenerator(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

