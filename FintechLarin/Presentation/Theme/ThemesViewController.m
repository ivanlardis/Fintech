//
//  ThemesViewController.m
//  FintechLarin
//
//  Created by Иван Lardis on 11/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _model = [[Themes alloc] initColor1:UIColor.blueColor
                                 color2:UIColor.greenColor
                                 color3:UIColor.redColor];
}

- (IBAction)actionTheme1:(id)sender {
    [_delegate themesViewController:self didSelectTheme:[_model theme1]];
}

- (IBAction)actionTheme2:(id)sender {
    [_delegate themesViewController:self didSelectTheme:[_model theme2]];
}

- (IBAction)actionTheme3:(id)sender {
    [_delegate themesViewController:self didSelectTheme:[_model theme3]];
}

- (IBAction)actionClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)setModel:(Themes *)model {
    [_model release];
    _model = [model retain];
}

- (Themes *)model {
    return _model;
}

- (id <ThemesViewControllerDelegate>)delegate {
    return _delegate;
}

- (void)setDelegate:(id <ThemesViewControllerDelegate>)delegate {
    _delegate = delegate;
}

- (void)dealloc {
    [_model release];
    _model = nil;
    _delegate = nil;

    [super dealloc];
}

@end
