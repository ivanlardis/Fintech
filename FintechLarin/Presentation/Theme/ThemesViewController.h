//
//  ThemesViewController.h
//  FintechLarin
//
//  Created by Иван Lardis on 11/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController {
    id <ThemesViewControllerDelegate> _delegate;
    Themes *_model;
}

@property(assign, nonatomic) id <ThemesViewControllerDelegate> delegate;
@property(retain, nonatomic) Themes *model;

@end

NS_ASSUME_NONNULL_END
