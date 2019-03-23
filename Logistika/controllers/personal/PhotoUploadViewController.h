//
//  PhotoUploadViewController.h
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SelectImageCell.h"
#import "ELCImagePickerHeader.h"
#import "ActionDelegate.h"

@interface PhotoUploadViewController : BasicViewController<AVCaptureMetadataOutputObjectsDelegate,ELCImagePickerControllerDelegate, UINavigationControllerDelegate, ActionDelegate>
@property (weak, nonatomic) IBOutlet UIStackView *stackImageCells;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@property (weak, nonatomic) IBOutlet UIView *viewPreview;

@property (strong, nonatomic) NSMutableArray* cells;

@property (nonatomic, assign) int limit;
@end
