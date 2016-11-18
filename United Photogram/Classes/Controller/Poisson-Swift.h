//
//  Poisson-Swift.h
//  United Photogram
//
//  Created by 宮崎一希 on 2016/11/18.
//  Copyright © 2016年 山浦功. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Poisson_Swift : UIViewController
@property (weak, nonatomic) IBOutlet UIView *UnitedPhoto;
@property (weak, nonatomic) IBOutlet UIButton *complete;

- (IBAction)completeUnite:(id)sender;
@property (weak, nonatomic) UIImage *baseImage;
@property (weak, nonatomic) UIImage *maskImage;
@property (weak, nonatomic) UIImage *srcImage;

@end

