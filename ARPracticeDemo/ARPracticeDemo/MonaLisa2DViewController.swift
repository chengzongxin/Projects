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
        configuration.planeDetection = .horizontal
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
        
        // 1.1 merge Image
        let mergeImage = addImage(drawImage: UIImage(named: "mona-lisa.jpg")!, boardImage: UIImage(named: "paint.png")!)
        
        material.diffuse.contents = mergeImage
        planeGeometry.materials = [material]

        // 2.
        let paintingNode = SCNNode(geometry: planeGeometry)
        paintingNode.transform = SCNMatrix4(hitResult.anchor!.transform)
        paintingNode.eulerAngles = SCNVector3(paintingNode.eulerAngles.x, paintingNode.eulerAngles.y, paintingNode.eulerAngles.z)
        paintingNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(paintingNode)
        grid.removeFromParentNode()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .horizontal else { return }
        let grid = Grid(anchor: planeAnchor)
        self.grids.append(grid)
        node.addChildNode(grid)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .horizontal else { return }
        let grid = self.grids.filter { grid in
            return grid.anchor.identifier == planeAnchor.identifier
            }.first

        guard let foundGrid = grid else {
            return
        }

        foundGrid.update(anchor: planeAnchor)
    }
    
    // MARK: Private Method
    func addImage(drawImage:UIImage, boardImage:UIImage) -> UIImage {
        //将底部的一张的大小作为所截取的合成图的尺寸
        let size = drawImage.size;
        
        let stretchBoardImage = scaleToSize(image: boardImage, newSize: CGSize(width: size.width * 1.2, height: size.height * 2))
        
        UIGraphicsBeginImageContext(stretchBoardImage.size)
        
        stretchBoardImage.draw(in: CGRect(origin: CGPoint.zero, size: stretchBoardImage.size))
        
        drawImage.draw(at: CGPoint(x: size.width * 0.1, y: 10))
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return resultImage
    }
    
    func scaleToSize(image:UIImage,newSize:CGSize) -> UIImage {
        let width = image.size.width
        let height = image.size.height
        let newSizeWidth = newSize.width
        let newSizeHeight = newSize.height
        var size:CGSize
        if width / height > newSizeWidth / newSizeHeight {
            size = CGSize(width: newSizeWidth, height: newSizeWidth * height / width)
        }else{
            size = CGSize(width: newSizeHeight * width / height, height: newSizeHeight)
        }
        
        let drawSize = CGSize(width: floor(size.width), height: floor(size.height))
        
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    //内缩放，一条变等于最长边，另外一条小于等于最长边
//    - (UIImage *)scaleToSize:(CGSize)newSize {
//      CGFloat width = self.size.width;
//      CGFloat height= self.size.height;
//      CGFloat newSizeWidth = newSize.width;
//      CGFloat newSizeHeight= newSize.height;
//      if (width <= newSizeWidth &&
//          height <= newSizeHeight) {
//          return self;
//      }
//
//      if (width == 0 || height == 0 || newSizeHeight == 0 || newSizeWidth == 0) {
//          return nil;
//      }
//      CGSize size;
//      if (width / height > newSizeWidth / newSizeHeight) {
//          size = CGSizeMake(newSizeWidth, newSizeWidth * height / width);
//      } else {
//          size = CGSizeMake(newSizeHeight * width / height, newSizeHeight);
//      }
//      return [self drawImageWithSize:size];
//    }
//    - (UIImage *)drawImageWithSize: (CGSize)size {
//      CGSize drawSize = CGSizeMake(floor(size.width), floor(size.height));
//      UIGraphicsBeginImageContext(drawSize);
//
//      [self drawInRect:CGRectMake(0, 0, drawSize.width, drawSize.height)];
//      UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//      UIGraphicsEndImageContext();
//      return newImage;
//    }
    
//    - (UIImage*)addImage:(UIImage*)image1 toImage:(UIImage*)image2
//
//    {
//
//
//
//         UIGraphicsBeginImageContext(CGSizeMake(image2.size.width, image2.size.height+image1.size.height));
//
//        // Draw image2，底下的
//
//        [image2drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
//
//        [image1drawInRect:CGRectMake(0,image2.size.height, image1.size.width, image1.size.height)];
//
//        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
//
//        UIGraphicsEndImageContext();
//
//        returnresultingImage;
//
//    }
//
//    作者：彬至睢阳
//    链接：https://www.jianshu.com/p/28e64faf5321
//    来源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
    
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


