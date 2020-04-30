//
//  ImageRecognizeViewController.swift
//  ARPracticeDemo
//
//  Created by Joe on 2020/4/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import ARKit

class ImageRecognizeViewController: UIViewController, ARSCNViewDelegate {

    var sceneView : ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        view.addSubview(sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
                   fatalError("AR Resources 资源文件不存在 。")
               }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        
        sceneView.session.run(configuration)
    }
    
    // MARK: ARSCNViewDelegate Method 监测到平面
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1. 判断anchor是否为ARImageAnchor
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        // 2. 在检测到的物体图像处添加 plane
        let referenceImage = imageAnchor.referenceImage
        let plane = SCNPlane(width: referenceImage.physicalSize.width,
                             height: referenceImage.physicalSize.height)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 3. 将plane添加到检测到的图像锚点处
        node.addChildNode(planeNode)
    }
}
