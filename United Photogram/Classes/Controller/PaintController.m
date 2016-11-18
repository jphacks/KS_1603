//
//  PaintController.m
//  United Photogram
//
//  Created by 宮崎一希 on 2016/11/17.
//  Copyright © 2016年 山浦功. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "PaintController.h"
#import "Poisson-Swift.h"

@interface PaintController ()
{
    UIBezierPath *bezierPath;
    UIImage *lastDrawImage;
    NSMutableArray *undoStack;
    NSMutableArray *redoStack;
}

@end

@implementation PaintController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    undoStack = [NSMutableArray array];
    redoStack = [NSMutableArray array];
    
    // ボタンのenabledを設定します。
    self.undoBtn.enabled = NO;
    self.redoBtn.enabled = NO;
    
    CGRect r1 = [[UIScreen mainScreen] bounds];
    // printf("w:%f, h:%f\n", r1.size.width, r1.size.height);
    CGRect r2 = [[UIScreen mainScreen] applicationFrame];
    // printf("w:%f, h:%f\n", r2.size.width, r2.size.height);
    
    self.canvas.image = self.image;
    UIImage *backgroundImage = self.canvas.image;
    
    // include picture
//    UIImage *backgroundImage  = [UIImage imageNamed:@"IMG_6877.JPG"];
    UIImage *status  = [UIImage imageNamed:@"IMG_6671.png"];
    
    
    // image resize
    CGImageRef imageRef = [status CGImage];
    size_t w = CGImageGetWidth(imageRef);
    size_t h = CGImageGetHeight(imageRef);
    size_t resize_w, resize_h;
    
    if (w>h) {
        resize_w = backgroundImage.size.width;
        resize_h = h * resize_w / w;
    } else {
        resize_h = backgroundImage.size.height;
        resize_w = w * resize_h / h;
    }
    UIGraphicsBeginImageContext(CGSizeMake(resize_w, resize_h));
    [status drawInRect:CGRectMake(0, 0, resize_w, resize_h)];
    status = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // create backgroundImage
    // set size captured
    
    UIGraphicsBeginImageContext(CGSizeMake(r1.size.width, r1.size.height));
    // replace images
    [backgroundImage drawAtPoint:CGPointMake(0, r1.size.height-r2.size.height)];
    //    [status drawAtPoint:CGPointMake(0, r1.size.height-r2.size.height+backgroundImage.size.height)];
    
    backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    // end output backgroundImage
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage: backgroundImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)undoBtnPressed:(id)sender
{
    // undoスタックからパスを取り出しredoスタックに追加します。
    UIBezierPath *undoPath = undoStack.lastObject;
    [undoStack removeLastObject];
    [redoStack addObject:undoPath];
    
    // 画面をクリアします。
    lastDrawImage = nil;
    self.canvas.image = nil;
    
    
    // 画面にパスを描画します。
    for (UIBezierPath *path in undoStack) {
        [self drawLine:path];
        lastDrawImage = self.canvas.image;
    }
    
    // ボタンのenabledを設定します。
    self.undoBtn.enabled = (undoStack.count > 0);
    self.redoBtn.enabled = YES;
}

- (IBAction)redoBtnPressed:(id)sender
{
    // redoスタックからパスを取り出しundoスタックに追加します。
    UIBezierPath *redoPath = redoStack.lastObject;
    [redoStack removeLastObject];
    [undoStack addObject:redoPath];
    
    // 画面にパスを描画します。
    [self drawLine:redoPath];
    lastDrawImage = self.canvas.image;
    
    // ボタンのenabledを設定します。
    self.undoBtn.enabled = YES;
    self.redoBtn.enabled = (redoStack.count > 0);
}


//保存メソッド(追加) 遷移も
- (IBAction)pushBtnPressed:(id)sender
{
    // save UIImage
    UIImage *image = self.canvas.image;
//    NSData *data = UIImagePNGRepresentation(image);
//    NSString *filePath = [NSString stringWithFormat:@"%@/test.png" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
//    NSLog(@"%@", filePath);
//    if ([data writeToFile:filePath atomically:YES]) {
//        NSLog(@"OK");
//    } else {
//        NSLog(@"Error");
//    }
    //[data release];
    
    
    
    Poisson_Swift *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"poissonVC"];
    
    vc.maskImage = image;
    vc.baseImage = _backgroundImage;
    vc.srcImage = _objectImage;
    
    [self presentViewController:vc animated:YES completion:nil];
}



- (IBAction)clearBtnPressed:(id)sender
{
    // 保持しているパスを全部削除します。
    [undoStack removeAllObjects];
    [redoStack removeAllObjects];
    
    // 画面をクリアします。
    lastDrawImage = nil;
    self.canvas.image = nil;
    
    // ボタンのenabledを設定します。
    self.undoBtn.enabled = NO;
    self.redoBtn.enabled = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチした座標を取得します。
    CGPoint currentPoint = [[touches anyObject] locationInView:self.canvas];
    
    // ボタン上の場合は処理を終了します。
    if (CGRectContainsPoint(self.undoBtn.frame, currentPoint)
        || CGRectContainsPoint(self.redoBtn.frame, currentPoint)
        || CGRectContainsPoint(self.clearBtn.frame, currentPoint)){
        return;
    }
    
    // パスを初期化します。
    bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineWidth = 16.0;
    [bezierPath moveToPoint:currentPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチ開始時にパスを初期化していない場合は処理を終了します。
    if (bezierPath == nil){
        return;
    }
    
    // タッチした座標を取得します。
    CGPoint currentPoint = [[touches anyObject] locationInView:self.canvas];
    
    // パスにポイントを追加します。
    [bezierPath addLineToPoint:currentPoint];
    
    // 線を描画します。
    [self drawLine:bezierPath];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチ開始時にパスを初期化していない場合は処理を終了します。
    if (bezierPath == nil){
        return;
    }
    
    // タッチした座標を取得します。
    CGPoint currentPoint = [[touches anyObject] locationInView:self.canvas];
    
    // パスにポイントを追加します。
    [bezierPath addLineToPoint:currentPoint];
    
    // 線を描画します。
    [self drawLine:bezierPath];
    
    // 今回描画した画像を保持します。
    lastDrawImage = self.canvas.image;
    
    // undo用にパスを保持して、redoスタックをクリアします。
    [undoStack addObject:bezierPath];
    [redoStack removeAllObjects];
    bezierPath = nil;
    
    // ボタンのenabledを設定します。
    self.undoBtn.enabled = YES;
    self.redoBtn.enabled = NO;
}

- (void)drawLine:(UIBezierPath*)path
{
    // 非表示の描画領域を生成します。
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    
    // 描画領域に、前回までに描画した画像を、描画します。
    [lastDrawImage drawAtPoint:CGPointZero];
    
    // 色をセットします。
    [[UIColor blackColor] setStroke];
    
    // 線を引きます。
    [path stroke];
    
    // 描画した画像をcanvasにセットして、画面に表示します。
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 描画を終了します。
    UIGraphicsEndImageContext();
}






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
