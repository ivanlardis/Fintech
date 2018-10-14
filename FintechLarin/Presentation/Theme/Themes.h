//
//  Themes.h
//  FintechLarin
//
//  Created by Иван Lardis on 11/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Themes : NSObject {
    UIColor *_theme1;
    UIColor *_theme2;
    UIColor *_theme3;
}

@property(retain, nonatomic) UIColor *theme1;
@property(retain, nonatomic) UIColor *theme2;
@property(retain, nonatomic) UIColor *theme3;

- (instancetype)initColor1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3;

- (void)dealloc;

@end


NS_ASSUME_NONNULL_END
