//
//  PhotoViewController.swift
//  Logistika
//
//  Created by BoHuang on 5/5/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary

class PhotoViewController: UIViewController ,ELCImagePickerControllerDelegate,UINavigationControllerDelegate,ActionDelegate {
    func elcImagePickerController(_ picker: ELCImagePickerController!, didFinishPickingMediaWithInfo info: [Any]!) {
        self.dismiss(animated: true, completion: nil)
        var images = [UIImage]()
        var paths = [URL]()
        for var1:Any in info {
            if let dict = var1 as? [String:Any] {
                if let type = dict["UIImagePickerControllerMediaType"] as? String, type == ALAssetTypePhoto {
                    if let image = dict["UIImagePickerControllerOriginalImage"] as? UIImage {
                        images.append(image)
                        paths.append(dict["UIImagePickerControllerReferenceURL"] as! URL)
                    }else {
                        debugPrint("UIImagePickerControllerReferenceURL = %@",dict)
                    }
                }else if let type = dict["UIImagePickerControllerMediaType"] as? String, type == ALAssetTypeVideo {
                    if let image = dict["UIImagePickerControllerOriginalImage"] as? UIImage {
                        images.append(image)
//                        paths.append(dict["UIImagePickerControllerReferenceURL"])
                    }else {
                        debugPrint("UIImagePickerControllerReferenceURL = %@",dict)
                    }
                }else {
                    debugPrint("Uknown asset type")
                }
            }
        }
        
        if self.cells.count < self.limit {
            for i in 0..<images.count {
                let cell = Bundle.main.loadNibNamed("SelectImageCell", owner: self, options: nil)![0] as! SelectImageCell
                cell.aDelegate = self
                let path = paths[i].absoluteString
                cell.setStyleWithData(["image":images[i] ,"path":path], mode: 1)
                self.cells.append(cell)
                self.stackImageCells.addArrangedSubview(cell)
                if self.cells.count >= self.limit {
                    break
                }
            }
        }
        
    }
    
    func elcImagePickerControllerDidCancel(_ picker: ELCImagePickerController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSubmit(_ obj: Any!, view: UIView!) {
        if let dict = obj as? NSDictionary, let cell = view as? SelectImageCell {
            if let found = self.cells.index(of: cell){
                self.cells.remove(at: found)
                cell.isHidden = true
            }
        }
    }
    

    @IBOutlet weak var segControl:UISegmentedControl!
    @IBOutlet weak var stackImageCells:UIStackView!
    @IBOutlet weak var viewPreview:UIView!
    @IBOutlet weak var imgSample: UIImageView!
    
    public var limit:Int = 0
    var cells = [SelectImageCell]()
    
    
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var isAllowed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgSample.isHidden = true
        // Do any additional setup after loading the view.
        let ac = UIAlertController.init(title: "Notification", message: "Take a picture in a good light environment where the object is centered in the picture. Offensive images will lead to uploader being blocked from application. Order Pick up will be upon review of the uploaded images", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "I AGREE", style: .default) { (action1) in
            
        }
        ac.addAction(action)
        
        self.present(ac, animated: true, completion: nil)
        
        if self.navigationController != nil{
            let item = UIBarButtonItem.init(title: "Upload", style: .plain, target: self, action: #selector(clickView(view:)))
            let atts = [NSFontAttributeName:UIFont.systemFont(ofSize: 18.0),NSForegroundColorAttributeName:UIColor.white]
            item.setTitleTextAttributes(atts, for: .normal)
            item.tag = 100
            
            self.navigationItem.rightBarButtonItems = [item]
        }
        self.segControl.tintColor = COLOR_PRIMARY;
        
        self.initCamera();
        self.isAllowed = true;
        
//        Global
//        CGlobal.grantedPermissionCamera { (ret) in
//            if ret {
//                self.initCamera()
//
//            }else{
//
//            }
//            self.isAllowed = ret
//            CGlobal.stopIndicator(self)
//        }
        
//        self.loadBeepSound()
    }
    
    @objc func clickView(view:UIView){
        let tag = view.tag
        switch tag {
        case 100:
            var data = [ItemModel]()
            for i in 0..<self.cells.count {
                let cell:SelectImageCell = self.cells[i] as! SelectImageCell
                let item = ItemModel.init()
                item.firstPackage()
                item.title = ""
                item.image = cell.filePath
                item.quantity = c_quantity[0] as! String
                item.weight = c_weight[0] as! String
                item.image_data = cell.image
                item.weight_value = Int32(c_weight_value[0]  as! String)!
                if item.image != nil && !(item.image! == "") {
                    data.append(item)
                }
            }
            if let navc = self.navigationController{
                for i in 0..<navc.viewControllers.count {
                    let vc = navc.viewControllers[i]
                    if vc is CameraOrderViewController {
                        let cvc = vc as! CameraOrderViewController
                        if cvc.cameraOrderModel == nil {
                            cvc.cameraOrderModel = OrderModel.init(dictionary: nil)
                        }
                        cvc.cameraOrderModel.itemModels.addObjects(from: data)
                        navc.popToViewController(cvc, animated: false)
                    }
                }
                
                // not found
                let ms = UIStoryboard.init(name: "Personal", bundle: nil)
                let cvc = ms.instantiateViewController(withIdentifier: "CameraOrderViewController") as! CameraOrderViewController
                cvc.cameraOrderModel = OrderModel.init(dictionary: nil)
                cvc.cameraOrderModel.itemModels.addObjects(from: data)
                navc.setViewControllers([cvc], animated: true)
            }
            
        default:
            break
        }
    }
    
    @IBAction func launchController(){
        if let elcPicker = ELCImagePickerController.init(imagePicker: ()){
            elcPicker.maximumImagesCount = self.limit - self.cells.count
            elcPicker.returnsOriginalImage = true; //Only return the fullScreenImage, not the fullResolutionImage
            elcPicker.returnsImage = true; //Return UIimage if YES. If NO, only return asset location information
            elcPicker.onOrder = true; //For multiple image selection, display and return order of selected images
            elcPicker.mediaTypes = [kUTTypeImage];
            //Supports image and movie types  (NSString *)kUTTypeMovie
            
            elcPicker.imagePickerDelegate = self;
            
            self.present(elcPicker, animated: true, completion: nil)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        // Setup your camera here...
        self.title = "Photo Upload"
        self.navigationController?.navigationBar.isHidden = false;
        
       
        
    }
    
    func initCamera(){
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if session!.canAddOutput(stillImageOutput) {
                session!.addOutput(stillImageOutput)
                // ...
                // Configure the Live Preview here...
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                videoPreviewLayer!.connection?.videoOrientation = .portrait
                viewPreview.layer.addSublayer(videoPreviewLayer!)
                videoPreviewLayer!.frame = self.calcRect()
                
                session!.startRunning()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
    }
    
    func calcRect()->CGRect{
        let rect = UIScreen.main.bounds
        var height = rect.size.height - 175
        if let vc = self.navigationController {
            if vc.navigationBar.isHidden == false {
                height = height - vc.navigationBar.frame.size.height
            }
        }
        height = height - UIApplication.shared.statusBarFrame.size.height
        let viewRect = CGRect.init(x: 0, y: 0, width: rect.size.width, height: height)
        
        return viewRect
        
    }
    
    var audioPlayer:AVAudioPlayer?
    
    func loadBeepSound() {
        if let beepFilePath = Bundle.main.path(forResource: "beep", ofType: "wav"),let beepURL = URL.init(string: beepFilePath) {
            do {
                try audioPlayer = AVAudioPlayer.init(contentsOf: beepURL)
                audioPlayer?.prepareToPlay()
            }catch {
                
            }
            
            
        }
        
    }
    @IBAction func segChanged(_ sender: Any) {
        let index = self.segControl.selectedSegmentIndex
        if index == 0 {
            
        }else{
            CGlobal.grantedPermissionPhotoLibrary { (ret) in
                if ret {
                    if self.cells.count < self.limit {
                        self.launchController()
                    }else{
                        self.alert()
                    }
                    self.segControl.selectedSegmentIndex = 0
                }
            }
            self.segControl.selectedSegmentIndex = 0
        }
    }
    
    func alert(){
        let string = "Can't take more than \(self.limit) images"
        CGlobal.alertMessage(string, title: nil)
    }
    
    @IBAction func captureNow(_ sender: Any) {
        if self.cells.count >= self.limit {
            self.alert()
            return
        }
        
        if self.isAllowed == false {
            return
        }
        
        if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo) {
            // ...
            // Code for photo capture goes here...
            
            CGlobal.showIndicator(self)
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) in
                // ...
                // Process the image data (sampleBuffer) here to get an image file we can put in our captureImageView
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    if let dataProvider = CGDataProvider(data: imageData as! CFData){
                        if let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: true, intent: .defaultIntent){
                            let image = UIImage.init(cgImage: cgImageRef, scale: 1.0, orientation: .right)
                            // ...
                            // Add the image to captureImageView here...
                            //self.imgSample.image = image
                            
                            let cell = Bundle.main.loadNibNamed("SelectImageCell", owner: self, options: nil)![0] as! SelectImageCell
                            cell.aDelegate = self
                            let filename = String.init(format: "%ld", Date.init().timeIntervalSince1970) + ".png"
                            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                            let documentsPath = paths[0]
                            let filePath = documentsPath + filename
                            let data = UIImagePNGRepresentation(image)
                            
                            cell.setStyleWithData(["image":image,"path":filePath], mode: 1)
                            
                            DispatchQueue.main.async {
                                self.stackImageCells .addArrangedSubview(cell)
                                self.cells.append(cell)
                                
                                CGlobal.stopIndicator(self)
                                
                                if let play = self.audioPlayer {
                                    play.play()
                                }
                            }
                        }
                    }
                    
                }
                
            })
        }else{
            print("if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo)")
        }
    }
    func convert(cmage:CIImage) -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
