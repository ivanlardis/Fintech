//
//  Themes.m
//  FintechLarin
//
//  Created by Иван Lardis on 11/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

#import "Themes.h"

@implementation Themes
- (instancetype)initColor1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3 {
    if (self = [super init]) {
        self.theme1 = color1;
        self.theme2 = color2;
        self.theme3 = color3;
    }
    return self;
}

- (UIColor *)theme1 {
    return _theme1;
}

- (void)setTheme1:(UIColor *)theme1 {
    [_theme1 release];
    _theme1 = [theme1 retain];

}

- (UIColor *)theme2 {
    return _theme2;
}

- (void)setTheme2:(UIColor *)theme2 {
    [_theme2 release];
    _theme2 = [theme2 retain];
}

- (UIColor *)theme3 {
    return _theme3;
}

- (void)setTheme3:(UIColor *)theme3 {
    [_theme3 release];
    _theme3 = [theme3 retain];
}

- (void)dealloc {
    [_theme1 release];
    [_theme2 release];
    [_theme3 release];
    _theme1 = nil;
    _theme2 = nil;
    _theme3 = nil;

    [super dealloc];
}

@end
