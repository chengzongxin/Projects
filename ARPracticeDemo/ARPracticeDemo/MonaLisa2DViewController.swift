//
//  Demo4ViewController.swift
//  ARPracticeDemo
//
//  Created by Joe on 2020/4/29.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class MonaLisa2DViewController: UIViewController , ARSCNViewDelegate{
    
    var sceneView : ARSCNView!
    var grids = [Grid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.scene = scene
        view.addSubview(sceneView)
        
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        sceneView.session.run(configuration)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer) {
        // Get 2D position of touch event on screen
        let touchPosition = gesture.location(in: sceneView)

        // Translate those 2D points to 3D points using hitTest (existing plane)
        let hitTestResults = sceneView.hitTest(touchPosition, types: .existingPlaneUsingExtent)
        
        // Get hitTest results and ensure that the hitTest corresponds to a grid that has been placed on a wall
        guard let hitTest = hitTestResults.first, let anchor = hitTest.anchor as? ARPlaneAnchor, let gridIndex = grids.firstIndex(where: { $0.anchor == anchor }) else {
            return
        }
        addPainting(hitTest, grids[gridIndex])
    }
    
    func addPainting(_ hitResult: ARHitTestResult, _ grid: Grid) {
        // 1.
        let planeGeometry = SCNPlane(width: 0.2, height: 0.35)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "mona-lisa.jpg")
        planeGeometry.materials = [material]

        // 2.
        let paintingNode = SCNNode(geometry: planeGeometry)
        paintingNode.transform = SCNMatrix4(hitResult.anchor!.transform)
        paintingNode.eulerAngles = SCNVector3(paintingNode.eulerAngles.x + (-Float.pi / 2), paintingNode.eulerAngles.y, paintingNode.eulerAngles.z)
        paintingNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(paintingNode)
        grid.removeFromParentNode()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = Grid(anchor: planeAnchor)
        self.grids.append(grid)
        node.addChildNode(grid)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = self.grids.filter { grid in
            return grid.anchor.identifier == planeAnchor.identifier
            }.first

        guard let foundGrid = grid else {
            return
        }

        foundGrid.update(anchor: planeAnchor)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let scene = SCNScene(named: "art.scnassets/ship.scn")
////        let ship = scene?.rootNode.childNode(withName: "ship", recursively: true)
////        ship?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
//        scnView = SCNView(frame: view.bounds)
//        scnView.scene = scene
//        scnView.allowsCameraControl = true
//        view.addSubview(scnView)
//        scnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapScnView(tapGes:))))
//        scnView.showsStatistics = true
//    }
//
//    @objc func tapScnView(tapGes:UITapGestureRecognizer) {
//        print(tapGes)
//        let point = tapGes.location(in: scnView)
//        // 类似射线检测，检测二维这个点向深无限延深，这个射线上的节点，返回一个数组，可用于单击选中，数组中第一个数据一般就是我们需要的节点。
//        let hitResults = scnView.hitTest(point, options: nil o9p]98431`12)
//        print(hitResults)
//    }
    
}


