//
//  WorldTrackingViewController.swift
//  ARPracticeDemo
//
//  Created by Joe on 2020/4/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import ARKit

class WorldTrackingViewController: UIViewController, ARSCNViewDelegate {

    var sceneView : ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        view.addSubview(sceneView)
        // 允许模型交互转动,模型会不再依附到实体世界上
//        sceneView.allowsCameraControl = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        sceneView.session.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.pause()
    }
    
    // MARK: ARSCNViewDelegate Method 监测到平面
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1. 判断当前新增的锚点类型
        guard anchor is ARPlaneAnchor else {
            return
        }
        
        // 2. 在检测到的平面处添加 box
//        let box = SCNBox(width: 0.08, height: 0.08, length: 0.08, chamferRadius: 0)
//        let boxNode = SCNNode(geometry: box)
//        node.addChildNode(boxNode)
        
//        let shipScn = SCNScene(named: "art.scnassets/ship.scn")!
//        node.addChildNode(shipScn.rootNode)
        
//        let ironManScn = SCNScene(named: "IronMan.scn")!
//        ironManScn.rootNode.position = SCNVector3(x: 0, y: -200, z: -200)
//        node.addChildNode(ironManScn.rootNode)
        
//        if (![anchor isMemberOfClass:[ARPlaneAnchor class]]) return;
//
//        // 添加一个3D平面模型，ARKit只有捕捉能力，锚点只是一个空间位置，想更加清楚看到这个空间，我们需要给控件添加一个平地的3D模型来渲染它
//        // 1. 获取捕捉到的平地锚点
        let planeAnchor: ARPlaneAnchor = anchor as! ARPlaneAnchor
//        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
//        // 2. 创建一个3D模型(系统捕捉到的平地是一个不规则的大小长方形，这里笔者q将其变成一个长方形，并且对平地做了一个缩放效果)
//        // 参数分别是长、宽、高、圆角
        let planeBox = SCNBox(width: CGFloat(planeAnchor.extent.x), height: 0, length: CGFloat(planeAnchor.extent.x), chamferRadius: 0)
//        SCNBox *planeBox = [SCNBox boxWithWidth:planeAnchor.extent.x * 0.3 height:0 length:planeAnchor.extent.x * 0.3 chamferRadius:0];
//        // 3. 使用Material渲染3D模型(默认模型是白色的)
        planeBox.firstMaterial?.diffuse.contents = UIColor.clear
//        planeBox.firstMaterial.diffuse.contents = [UIColor clearColor];
//        // 4. 创建一个基于3D物体模型的节点
        let planeNode = SCNNode(geometry: planeBox)
//        SCNNode *planeNode = [SCNNode nodeWithGeometry:planeBox];
//        // 5. 设置节点的位置为捕捉到的平地的锚点的中心位置
//        // SceneKit中节点的位置position是一个基于3D坐标系的矢量坐标SCNVector3Make
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.x)
//        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
//
        node.addChildNode(planeNode)
//        [node addChildNode:planeNode];
//
//        // 6. 创建一个花瓶场景
//        let modelName = "art.scnassets/247_House 15_obj copy.scn"
        let modelName = "art.scnassets/vase/vase.scn"
        let scene = SCNScene(named: modelName)
//        SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/vase/vase.scn"];
//        // 7. 获取花瓶节点
//        // 一个场景有多个节点，所有场景有且只有一个根节点，其它所有节点都是根节点的子节点
        let vaseNode = scene!.rootNode.childNodes.first!
//        SCNNode *vaseNode = scene.rootNode.childNodes.firstObject;
//        // 8. 设置花瓶节点的位置为捕捉到的平地的位置，如果不设置，则默认为原点位置也就是相机位置
        vaseNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.x)
//        vaseNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
//        // 9. 将花瓶节点添加到屏幕中
//        // !!!!FBI WARNING: 花瓶节点是添加到代理捕捉到的节点中，而不是AR视图的根接节点。
//        // 因为捕捉到的平地锚点是一个本地坐标系，而不是世界坐标系
        node.addChildNode(vaseNode)
//        [node addChildNode:vaseNode];
        
        
    }

}
