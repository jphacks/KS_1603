//
//  PaintController.h
//  United Photogram
//
//  Created by 宮崎一希 on 2016/11/17.
//  Copyright © 2016年 山浦功. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *undoBtn;
- (IBAction)undoBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *redoBtn;
- (IBAction)redoBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
- (IBAction)clearBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *canvas;

@property (weak, nonatomic) UIImage *image;

@property (weak, nonatomic) UIImage *backgroundImage;

@property (weak, nonatomic) UIImage *objectImage;

@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
- (IBAction)pushBtnPressed:(id)sender;


@end
