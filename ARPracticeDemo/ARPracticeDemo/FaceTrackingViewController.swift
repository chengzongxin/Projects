//
//  FaceTrackingViewController.swift
//  ARPracticeDemo
//
//  Created by Joe on 2020/4/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import ARKit

class FaceTrackingViewController: UIViewController, ARSCNViewDelegate {

    var sceneView : ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (ARConfiguration.isSupported) {
            print("ARKit is supported. You can work with ARKit")
        } else {
            print("ARKit is not supported. You cannot work with ARKit")
        }

        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        view.addSubview(sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let config = ARFaceTrackingConfiguration()
        sceneView.session.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.pause()
    }
    
    // MARK: ARSCNViewDelegate Method 监测到平面
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1. 判断当前新增的锚点类型
        guard anchor is ARFaceAnchor else {
            return
        }
        
        // 2. 在检测到的平面处添加 box
        let box = SCNBox(width: 0.08, height: 0.08, length: 0.08, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        node.addChildNode(boxNode)
    }

}
