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
    var forward = 0.0
    var up = 0.0
    var left = 0.0
    var right = 0.0
    var down = 0.0
    let configuration = ARWorldTrackingConfiguration()
    var planeScene: SCNScene?
    var planeNode: SCNNode?
    let timeInterval = 0.018

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
        if up == 1 || left == 1 || right == 1 || down == 1 || forward == 1 {
            //let position = self.sceneView.scene.rootNode.childNode(withName: "plane", recursively:true)?.position
            //let rotation = planeNode?.rotation
            planeNode?.runAction(SCNAction.rotate(by: .pi * 0.02, around: planeNode!.convertVector(SCNVector3(down - up, 0, left - right), to: planeNode!.parent), duration: TimeInterval(timeInterval)))
            planeNode?.position = planeNode!.position + SCNVector3(planeNode!.worldTransform.m21 * -1.0, planeNode!.worldTransform.m22 * -1.0, planeNode!.worldTransform.m23 * -1.0)
            //planeNode?.position = planeNode!.convertVector(SCNVector3(0, -0.01, 0), to: planeNode!.parent)
            //.runAction(SCNAction.moveBy(x: 0, y: CGFloat(0.01 * forward), z: 0, duration: timeInterval / 2))
            //planeNode?.position = planeNode!.convertVector(SCNVector3(0, -0.01 * up, 0), to: planeNode!.parent)
                //By(x: CGFloat(0.1 * (down - up)), y: 0, z: CGFloat(0.1 * (left - right)), duration: timeInterval / 2))
            //self.sceneView.scene.rootNode.childNode(withName: "plane", recursively:true)?
            //self.sceneView.scene.rootNode.childNode(withName: "plane", recursively:true)?.position = position! + SCNVector3(0, 0.01, 0)
            //.runAction(SCNAction.moveBy(x: 0, y: CGFloat(0.01 * forward), z: 0, duration: timeInterval / 2))
        }
    }
    
    func addPlaneNode() {
        planeScene = SCNScene(named: "art.scnassets/Plane.scn")     //this initializes the plane image
        planeNode = planeScene?.rootNode.childNode(withName: "plane", recursively: false)       //initializes the node ('withName: "plane"' represents the name of the scenegraph located within the Plane.scn file it titles the object (DOES NOT REPRESENT THE FILE NAME)
        planeNode?.position = SCNVector3(0, 0.3, 0)       //0, 0, 0 represents the xyz graph origin
        planeNode?.scale = SCNVector3(0.01, 0.01, 0.01)     //down scales the plane by 100
        self.sceneView.scene.rootNode.addChildNode(planeNode!)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(ViewController.actionTimer), userInfo: nil, repeats: true)
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
        up = 1
    }
    @IBAction func upButtonUp(_ sender: Any) {
        up = 0
    }

    
    @IBAction func rightButtonDown(_ sender: Any) {
        right = 1
    }
    @IBAction func rightButtonUp(_ sender: Any) {
        right = 0
    }

    @IBAction func downButtonDown(_ sender: Any) {
        down = 1
    }
    @IBAction func downButtonUp(_ sender: Any) {
        down = 0
    }

    
    @IBAction func leftButtonDown(_ sender: Any) {
        left = 1
    }
    @IBAction func leftButtonUp(_ sender: Any) {
        left = 0
    }

    
    @IBAction func planeForwardButtonDown(_ sender: Any) {
        forward = 1
    }
    @IBAction func planeForwardButtonUp(_ sender: Any) {
        forward = 0
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
    
    /*func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }*/
}
func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

func + (left: SCNVector4, right: SCNVector4) -> SCNVector4 {
    return SCNVector4Make(left.x + right.x, left.y + right.y, left.z + right.z, left.w + right.w)
}

