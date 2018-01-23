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
    var planeNodeSet = false
    let configuration = ARWorldTrackingConfiguration()
    var planeScene: SCNScene?
    var planeNode: SCNNode?
    var alienScene: SCNScene?
    var alienNode: SCNNode?
    let timeInterval = 0.018
    //var aliens : [SCNNode] = []
    let alienSpeed : Float = 0.3
    let planeSpeed : Float = 1.0
    var bulletPower : Float = 25.0
    var id = 0

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
        if up == 1 || left == 1 || right == 1 || down == 1 {
            planeNode?.runAction(SCNAction.rotate(by: .pi * 0.02, around: planeNode!.convertVector(SCNVector3(down - up, 0, left - right), to: planeNode!.parent), duration: TimeInterval(timeInterval)))
        }
        if forward == 1 {
            planeNode?.position = planeNode!.position + SCNVector3(planeNode!.worldTransform.m21 * -1.0 * planeSpeed, planeNode!.worldTransform.m22 * -1.0 * planeSpeed, planeNode!.worldTransform.m23 * -1.0 * planeSpeed)
        } //just for testing
        if id != 0 {
            for i in 0 ..< id {
                let tempNode = self.sceneView.scene.rootNode.childNode(withName: "alien" + String(i), recursively:true)
                tempNode?.look(at: planeNode!.position)
                tempNode?.runAction(SCNAction.move(by: SCNVector3(tempNode!.worldTransform.m31 * -1.0 * alienSpeed, tempNode!.worldTransform.m32 * -1.0 * alienSpeed, tempNode!.worldTransform.m33 * -1.0 * alienSpeed), duration: 0.015))
            }
        }
        
        /*for child in aliens {
            child.runAction(SCNAction.move(by: SCNVector3(child.worldTransform.m31 * -1.0 * alienSpeed, child.worldTransform.m32 * -1.0 * alienSpeed, child.worldTransform.m33 * -1.0 * alienSpeed), duration: 0.015))
            //.position = child.position + SCNVector3(child.worldTransform.m31 * -1.0 * alienSpeed, child.worldTransform.m32 * -1.0 * alienSpeed, child.worldTransform.m33 * -1.0 * alienSpeed)
        }*/
    }
    
    func addPlaneNode() {
        if !planeNodeSet {
            planeScene = SCNScene(named: "art.scnassets/Plane.scn")     //this initializes the plane image
            planeNode = planeScene?.rootNode.childNode(withName: "plane", recursively: false)       //initializes the node ('withName: "plane"' represents the name of the scenegraph located within the Plane.scn file it titles the object (DOES NOT REPRESENT THE FILE NAME)
            planeNode?.position = SCNVector3(0, 0.3, 0)       //0, 0, 0 represents the xyz graph origin
            planeNode?.scale = SCNVector3(0.01, 0.01, 0.01)     //down scales the plane by 100
            self.sceneView.scene.rootNode.addChildNode(planeNode!)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(ViewController.actionTimer), userInfo: nil, repeats: true)
            planeNodeSet = true
        }
    }
    
    func addAlienNode() {
        if planeNodeSet {
            alienScene = SCNScene(named: "art.scnassets/alien.scn")
            let name : String = "alien" + String(id)
            alienNode = alienScene?.rootNode.childNode(withName: "alien", recursively: false)
            alienNode?.position = SCNVector3(self.randomLocationGenerator(firstNum: -1,secondNum: 1),
                                             self.randomLocationGenerator(firstNum: -1,secondNum: 1),
                                             self.randomLocationGenerator(firstNum: -1,secondNum: 1))
            alienNode?.scale = SCNVector3(0.01, 0.01, 0.01)
            //let constraint = SCNLookAtConstraint.init(target: planeNode!)
            //alienNode?.constraints = [constraint]
            alienNode?.name = name
            id = id + 1
            self.sceneView.scene.rootNode.addChildNode(alienNode!)
        }
    }
    
    @IBAction func shootBullet(_ sender: Any) {
        shootBullet()
    }
    
    func shootBullet() {
        if planeNodeSet {
            let bullet = SCNNode(geometry: SCNSphere(radius:0.005))
            bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            bullet.position = planeNode!.position
            let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: bullet, options: nil))
            body.isAffectedByGravity = false
            bullet.physicsBody = body
            //bullet.physicsBody?.velocity = SCNVector3(planeNode!.worldTransform.m21 * -1.0 * bulletPower, planeNode!.worldTransform.m22 * -1.0 * bulletPower, planeNode!.worldTransform.m23 * -1.0 * bulletPower)
            bullet.physicsBody?.applyForce(SCNVector3(planeNode!.worldTransform.m21 * -1.0 * bulletPower, planeNode!.worldTransform.m22 * -1.0 * bulletPower, planeNode!.worldTransform.m23 * -1.0 * bulletPower), asImpulse: true)
            self.sceneView.scene.rootNode.addChildNode(bullet)
        }
    }
    
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
}
func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

func + (left: SCNVector4, right: SCNVector4) -> SCNVector4 {
    return SCNVector4Make(left.x + right.x, left.y + right.y, left.z + right.z, left.w + right.w)
}
