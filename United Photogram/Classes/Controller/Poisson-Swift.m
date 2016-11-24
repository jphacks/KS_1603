//
//  Poisson-Swift.m
//  TestPoisson
//
//  Created by 宮崎一希 on 2016/11/14.
//  Copyright © 2016年 tetra. All rights reserved.
//

#import "Poisson-Swift.h"

@interface Poisson_Swift ()

@end

@implementation Poisson_Swift

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ベース（合成先）画像のピクセル値を取得
//    UIImage *baseImage = [UIImage imageNamed:@"IMG_6671.png"];
    CGImageRef baseCGImage = _baseImage.CGImage;
    size_t baseBytesPerRow = CGImageGetBytesPerRow(baseCGImage);
    CGDataProviderRef baseDataProvider = CGImageGetDataProvider(baseCGImage);
    CFDataRef baseData = CGDataProviderCopyData(baseDataProvider);
    UInt8 *basePixels = (UInt8*)CFDataGetBytePtr(baseData); // f*_p
    
    // 合成結果のピクセル値の初期値をベース画像と同じものに設定
    // これを反復法で書き換えていく
    CFDataRef resultData = CGDataProviderCopyData(baseDataProvider);
    UInt8 *resultPixels = (UInt8*)CFDataGetBytePtr(resultData); // f_p
    
    // ソース（合成したい）画像とそれに対するマスク画像
//    UIImage *srcImage = [UIImage imageNamed:@"proceed.jpeg"];
    CGImageRef srcCGImage = _srcImage.CGImage;
    size_t srcBytesPerRow = CGImageGetBytesPerRow(srcCGImage);
    CGDataProviderRef srcDataProvider = CGImageGetDataProvider(srcCGImage);
    CFDataRef srcData = CGDataProviderCopyData(srcDataProvider);
    UInt8 *srcPixels = (UInt8*)CFDataGetBytePtr(srcData); // g_p
    
    // マスク画像は切り取る部分が黒 rgb(0,0,0)
    // マスクをかけた結果はいらないのでマスク画像だけでOK
//    UIImage *maskImage = [UIImage imageNamed:@"mask.jpg"];
    CGImageRef maskCGImage = _maskImage.CGImage;
    size_t maskBytesPerRow = CGImageGetBytesPerRow(maskCGImage);
    CGDataProviderRef maskDataProvider = CGImageGetDataProvider(maskCGImage);
    CFDataRef maskData = CGDataProviderCopyData(maskDataProvider);
    UInt8 *maskPixels = (UInt8*)CFDataGetBytePtr(maskData);
    
    // Importing gradients と Mixing gradients の切り替え
    bool is_mixing_gradients = true;
    
    // 収束判定に使う
    double dx, absx, previous_epsilon = 1.0;
    
    do {
        dx = 0.0; absx = 0.0;
        
        // 簡単のため四隅の1ピクセルは考慮しない（近傍点が1つ減ってしまって例外になる）
        // 画像サイズがすべて同じものと仮定しているのでLengthやWidthを心配する必要は無い
        for(int y=1; y<_baseImage.size.height-1; y++) {
            for(int x=1; x<_baseImage.size.width-1; x++) {
                
                // BytesPerRowは必ずしもすべて同じとは限らないので別々に定義する
                int p_mask_offset = y*maskBytesPerRow + x*4;
                
                // マスク画像の黒領域 = ソース画像の合成領域
                if(*(maskPixels+p_mask_offset+0)==0 &&
                   *(maskPixels+p_mask_offset+1)==0 &&
                   *(maskPixels+p_mask_offset+2)==0) {
                    
                    // p（現在見ているピクセル）
                    unsigned long p_base_offset = y*baseBytesPerRow + x*4;
                    unsigned long p_src_offset = y*srcBytesPerRow + x*4;
                    
                    // q（pの4近傍）
                    int q_base_offset[4] = {(y-1)*baseBytesPerRow+x*4, (y+1)*baseBytesPerRow+x*4, y*baseBytesPerRow+(x-1)*4, y*baseBytesPerRow+(x+1)*4};
                    int q_src_offset[4] = {(y-1)*srcBytesPerRow+x*4, (y+1)*srcBytesPerRow+x*4, y*srcBytesPerRow+(x-1)*4, y*srcBytesPerRow+(x+1)*4};
                    int q_mask_offset[4] = {(y-1)*maskBytesPerRow+x*4, (y+1)*maskBytesPerRow+x*4, y*maskBytesPerRow+(x-1)*4, y*maskBytesPerRow+(x+1)*4};
                    
                    for(int rgb=0; rgb<3; rgb++) { // RGB各色に対して
                        int sum_fq = 0;
                        int sum_vpq = 0;
                        int sum_boundary = 0;
                        
                        for(int n=0; n<4; n++) { // 4近傍それぞれに対して
                            if(*(maskPixels+q_mask_offset[n]+0)==0 &&
                               *(maskPixels+q_mask_offset[n]+1)==0 &&
                               *(maskPixels+q_mask_offset[n]+2)==0) {
                                sum_fq += *(resultPixels+q_base_offset[n]+rgb);
                            } else {
                                sum_boundary += *(basePixels+q_base_offset[n]+rgb);
                            }
                            
                            if(is_mixing_gradients &&
                               abs(*(basePixels+p_base_offset+rgb) - *(basePixels+q_base_offset[n]+rgb)) >
                               abs(*(srcPixels+p_src_offset+rgb) - *(srcPixels+q_src_offset[n]+rgb))) {
                                sum_vpq += *(basePixels+p_base_offset+rgb) - *(basePixels+q_base_offset[n]+rgb);
                            } else {
                                sum_vpq += *(srcPixels+p_src_offset+rgb) - *(srcPixels+q_src_offset[n]+rgb);
                            }
                        }
                        double new_value = (sum_fq+sum_vpq+sum_boundary)/4.0;
                        dx += fabs(new_value - *(resultPixels+p_base_offset+rgb));
                        absx += fabs(new_value);
                        if(new_value < 0.0){ new_value = 0.0; }
                        if(new_value > 255.0){ new_value = 255.0; }
                        *(resultPixels+p_base_offset+rgb) = round(new_value);
                    }
                }
            }
        }
        
        // 収束判定
        double epsilon = dx/absx;
        if(!epsilon || previous_epsilon-epsilon <= 0.05) break;
        else previous_epsilon = epsilon;
    } while(true);
    
    // 収束後の合成結果のピクセル値からUIImageを構成
    CGDataProviderRef resultDataProvider = CGDataProviderCreateWithCFData(resultData);
    CGImageRef resultCGImage = CGImageCreate(CGImageGetWidth(baseCGImage),
                                             CGImageGetHeight(baseCGImage),
                                             CGImageGetBitsPerComponent(baseCGImage),
                                             CGImageGetBitsPerPixel(baseCGImage),
                                             baseBytesPerRow,
                                             CGImageGetColorSpace(baseCGImage),
                                             CGImageGetBitmapInfo(baseCGImage),
                                             resultDataProvider,
                                             NULL,
                                             CGImageGetShouldInterpolate(baseCGImage),
                                             CGImageGetRenderingIntent(baseCGImage));
    
    UIImage *resultImage = [UIImage imageWithCGImage:resultCGImage];
    
//    UIImage *hamekomiGazo = [UIImage imageNamed:@"ajjdfas.png"];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:resultImage];
    
    iv.image = resultImage;
    
    [self.UnitedPhoto addSubview:iv];
    
    
    
    
    // Core Foundation ObjectsはARC対象外なのでreleaseをする
    CGImageRelease(baseCGImage);
    CFRelease(baseData);
    
    CGImageRelease(srcCGImage);
    CFRelease(srcData);
    
    CGImageRelease(maskCGImage);
    CFRelease(maskData);
    
    CGImageRelease(resultCGImage);
    CFRelease(resultDataProvider);
    CFRelease(resultData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeUnite:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
