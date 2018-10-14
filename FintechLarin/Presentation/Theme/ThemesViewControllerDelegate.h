//
//  ThemesViewControllerDelegate.h
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ThemesViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol ThemesViewControllerDelegate <NSObject>
- (void)themesViewController:(ThemesViewController *)controller
              didSelectTheme:(UIColor *)selectedTheme;
@end

NS_ASSUME_NONNULL_END
