//
//  ViewController.swift
//  World Tracking
//
//  Created by Chad Schadewald on 6/22/22.
//

import UIKit
import ARKit

class ViewController: UIViewController
{
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any)
    {
        let wallsNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        let roofNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.075, length: 0.1))
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.05))
        
        wallsNode.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        wallsNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        
        roofNode.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        roofNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        
        doorNode.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
//        node.geometry = SCNSphere(radius: 0.05)
//        node.geometry = SCNCylinder(radius: 0.05, height: 0.2)
//        node.geometry = SCNCone(topRadius: 0, bottomRadius: 0.1, height: 0.2)
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.4, y: 0))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
        
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        
        wallsNode.position = SCNVector3(x: 0, y: 0,z: -0.3)
        roofNode.position = SCNVector3(x: 0, y: 0.05, z: 0)
        doorNode.position = SCNVector3(x: 0, y: -0.025, z: 0.051)
        
        wallsNode.addChildNode(roofNode)
        wallsNode.addChildNode(doorNode)
        self.sceneView.scene.rootNode.addChildNode(wallsNode)
    }
    
    @IBAction func reset(_ sender: Any)
    {
        self.restartSession()
    }
    
    func restartSession()
    {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes
        { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

