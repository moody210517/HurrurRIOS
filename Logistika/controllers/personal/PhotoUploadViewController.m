//
//  PhotoUploadViewController.m
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PhotoUploadViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CGlobal.h"
#import "ItemModel.h"
#import "CameraOrderViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>

@interface PhotoUploadViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;
@property (nonatomic) BOOL captured;
@property (nonatomic, strong) UIImage* theImage;


@end

@implementation PhotoUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    [self initCamera];
    _cells = [[NSMutableArray alloc] init];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Notification" message:@"Take a picture in a good light environment where the object is centered in the picture. Offensive images will lead to uploader being blocked from application. Order Pick up will be upon review of the uploaded images" delegate:self cancelButtonTitle:nil otherButtonTitles:@"I AGREE", nil];
    [alert show];
    
    if (self.navigationController!= nil) {
//        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 0, 20, 20);
//        [btn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = 100;
        
//        UIImage* image = [UIImage imageNamed:@"ic_action_done_38.png"];
//        [btn setImage:image forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//        btn.titleLabel.text = @"Uppload";
//        NSMutableAttributedString* titleString = [[NSMutableAttributedString alloc] initWithString:@"Upload"];
//        [titleString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, [titleString length])];
//        [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [titleString length])];
//        [btn setAttributedTitle:titleString forState:UIControlStateNormal];
        
        //[btn setTitle:@"Upload" forState:UIControlStateNormal];

//        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        UIBarButtonItem*item = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(clickView:)];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f weight:UIFontWeightHeavy],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
        item.tag = 100;
        
        self.navigationItem.rightBarButtonItems = @[item];
      
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_action_done.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickView:)];
//
//        UIBarButtonItem* flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        self.navigationItem.rightBarButtonItems = @[flex,rightItem];
//        [[self navigationItem] setRightBarButtonItem:rightItem];
    }
    
    self.segControl.tintColor = COLOR_PRIMARY;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = false;
   self.title = @"Photo Upload";
}
-(void)clickView:(UIView*)sender{
    int tag = (int) sender.tag;
    switch (tag) {
        case 100:
        {
            
            NSMutableArray* data = [[NSMutableArray alloc] init];
            for (int i=0; i<self.cells.count; i++) {
                SelectImageCell* cell = self.cells[i];
                ItemModel *item = [[ItemModel alloc] init];
                [item firstPackage];
                item.title = @"";
                item.image = cell.filePath;
                item.quantity = c_quantity[0];
                item.weight = c_weight[0];
                item.image_data = cell.image;
                item.weight_value = [c_weight_value[0] intValue];
                if (item.image!=nil && ![item.image isEqualToString:@""]) {
                    [data addObject:item];
                }
            }
            if (self.navigationController!=nil) {
                UINavigationController* navc = self.navigationController;
                for (int i=0; i<navc.viewControllers.count; i++) {
                    UIViewController*vc = navc.viewControllers[i];
                    if ([vc isKindOfClass:[CameraOrderViewController class]]) {
                        // hgc need
                        CameraOrderViewController* cvc = (CameraOrderViewController*)vc;
                        if (cvc.cameraOrderModel == nil) {
                            cvc.cameraOrderModel = [[OrderModel alloc] initWithDictionary:nil];
                        }
                        [cvc.cameraOrderModel.itemModels addObjectsFromArray:data];
                        [navc popToViewController:cvc animated:false];
                        return;
                    }
                }
                // not found
                UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                CameraOrderViewController* cvc = (CameraOrderViewController*)[ms instantiateViewControllerWithIdentifier:@"CameraOrderViewController"];
                cvc.cameraOrderModel = [[OrderModel alloc] initWithDictionary:nil];
                [cvc.cameraOrderModel.itemModels addObjectsFromArray:data];
                [navc setViewControllers:@[cvc] animated:true];
                return;
            }
            break;
        }
        default:
            break;
    }
}
-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}
-(void)initCamera{
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSound];
    
    self.captured = NO;
    
    [CGlobal showIndicator:self];
    [CGlobal grantedPermissionCamera:^(BOOL ret) {
        if (ret) {
            // granted
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startReading];
                
                [CGlobal stopIndicator:self];
            });
            
        }else{
            // not granted
        }
    }];
}
- (IBAction)launchController
{
    // objectForKeyedSubscript
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = _limit - self.cells.count; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    //Supports image and movie types  (NSString *)kUTTypeMovie
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (BOOL)startReading {
    
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [_captureSession addOutput:output];
    
    
    output.videoSettings = @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    
    // Create a new serial dispatch queue.
    dispatch_queue_t queue;
    queue = dispatch_queue_create("myQueue", NULL);
    
    [output setSampleBufferDelegate:self queue:queue];
//    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //[captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
//    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode93Code,
//                                                   AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,
//                                                   nil]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat height = rect.size.height - 175;
    if (self.navigationController != nil) {
        if (self.navigationController.navigationBar.isHidden == false) {
            height = height - self.navigationController.navigationBar.frame.size.height;
        }
    }
    height = height - [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect viewRect = CGRectMake(0, 0, rect.size.width, height);
    
    CGRect org = _viewPreview.layer.bounds;
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:viewRect];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}
- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}
-(IBAction)captureNow
{
    if (self.cells.count<self.limit) {
        if (self.theImage!=nil) {
            [CGlobal showIndicator:self];
            //NSArray* cells = @[_imgCell1,_imgCell2,_imgCell3];
            SelectImageCell* cell  = (SelectImageCell*)[[NSBundle mainBundle] loadNibNamed:@"SelectImageCell" owner:self options:nil][0];
            cell.aDelegate = self;
            
            NSString*filename = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
            filename = [filename stringByAppendingString:@".png"];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *filePath = [documentsPath stringByAppendingPathComponent:filename];
            NSData* data = UIImagePNGRepresentation(self.theImage);
            [data writeToFile:filePath atomically:YES];
            
            [cell setStyleWithData:@{@"image":self.theImage,@"path":filePath} Mode:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.stackImageCells addArrangedSubview:cell];
                [self.cells addObject:cell];
                
                [CGlobal stopIndicator:self];
            });
            
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }else{
        [self alert];
    }
    
}
-(void)alert{
    NSString* string = [NSString stringWithFormat:@"Can't take more than %d images",self.limit];
    [CGlobal AlertMessage:string Title:nil];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    CGImageRef cgImage = [self imageFromSampleBuffer:sampleBuffer];
    UIImage*image = [UIImage imageWithCGImage: cgImage ];
    CGImageRelease( cgImage );
    
    self.theImage = image;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
//    NSData* data = UIImagePNGRepresentation(image);
//    [data writeToFile:filePath atomically:YES];
    
}
- (CGImageRef) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    CGContextRelease(newContext);
    
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    return newImage;
}
- (IBAction)segChanged:(id)sender {
    NSInteger index = _segControl.selectedSegmentIndex;
    if (index == 0) {
        // camera
        
    }else{
        // launch gallery
        [CGlobal grantedPermissionPhotoLibrary:^(BOOL ret) {
            if (ret) {
                if (self.cells.count<self.limit) {
                    [self launchController];
                    
                }else{
                    [self alert];
                }
                self.segControl.selectedSegmentIndex = 0;
            }
        }];
        self.segControl.selectedSegmentIndex = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePicture:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
                [paths addObject:[dict objectForKey:UIImagePickerControllerReferenceURL]];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    if (self.cells.count<_limit) {
        for(int i=0; i<[images count]; i++){
            SelectImageCell* cell  = (SelectImageCell*)[[NSBundle mainBundle] loadNibNamed:@"SelectImageCell" owner:self options:nil][0];
            cell.aDelegate = self;
            NSString* path = [paths[i] absoluteString];
            [cell setStyleWithData:@{@"image":images[i],@"path":path} Mode:1];
            [self.cells addObject:cell];
            [self.stackImageCells addArrangedSubview:cell];
            if (self.cells.count>=self.limit) {
                break;
            }
        }
    }
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didSubmit:(id)obj View:(UIView *)view{
    if ([obj isKindOfClass:[NSDictionary class]] && [view isKindOfClass:[SelectImageCell class]]) {
        NSDictionary*dict = (NSDictionary*)obj;
        SelectImageCell* cell = view;
        NSInteger found  =[self.cells indexOfObject:cell];
        if (found != NSNotFound) {
            [self.cells removeObjectAtIndex:found];
            cell.hidden = true;
        }
    }
}
-(void)didCancel:(UIView *)view{
    
}
@end
