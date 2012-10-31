//
//  DCPaletteViewCtrl.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCPaletteViewCtrl.h"

@interface DCPaletteViewCtrl ()

@end

@implementation DCPaletteViewCtrl

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    do {
        // initialize the RGB sliders with
        // a StrokeColorCommand
        DCSetStrokeColorCommand *colorCommand = (DCSetStrokeColorCommand *)self.redSlider.command;
        
        // set each color component provider
        // to the color command
        [colorCommand setRGBValuesProvider: ^(CGFloat *red, CGFloat *green, CGFloat *blue) {
             *red = self.redSlider.value;
             *green = self.greenSlider.value;
             *blue = self.blueSlider.value;
         }];
        
        // set a post-update provider to the command
        // for any callback after a new color is set
        [colorCommand setPostColorUpdateProvider: ^(UIColor *color) {
             self.paletteView.backgroundColor = color;
         }];
        
        colorCommand.delegate = self;
        
        DCSetStrokeSizeCommand *sizeCommand = (DCSetStrokeSizeCommand *)self.sizeSlider.command;
        sizeCommand.delegate = self;
        
        
        // restore the original values of the sliders
        // and the color of the small palette view
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        CGFloat redValue = [userDefaults floatForKey:@"red"];
        CGFloat greenValue = [userDefaults floatForKey:@"green"];
        CGFloat blueValue = [userDefaults floatForKey:@"blue"];
        CGFloat sizeValue = [userDefaults floatForKey:@"size"];
        
        self.redSlider.value = redValue;
        self.greenSlider.value = greenValue;
        self.blueSlider.value = blueValue;
        self.sizeSlider.value = sizeValue;
        
        UIColor *color = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
        
        self.paletteView.backgroundColor = color;
    } while (NO);
}

- (void)viewDidAppear:(BOOL)animated {
    do {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setFloat:self.redSlider.value forKey:@"red"];
        [userDefaults setFloat:self.greenSlider.value forKey:@"green"];
        [userDefaults setFloat:self.blueSlider.value forKey:@"blue"];
        [userDefaults setFloat:self.sizeSlider.value forKey:@"size"];
    } while (NO);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_colorTilteLabel release];
    [_sizeTitleLabel release];
    [_redSlider release];
    [_greenSlider release];
    [_blueSlider release];
    [_paletteView release];
    [_sizeSlider release];
    [super dealloc];
}

#pragma mark SetStrokeColorCommandDelegate methods

- (void)command:(DCSetStrokeColorCommand *)command didRequestColorComponentsForRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue {
    *red = self.redSlider.value;
    *green = self.greenSlider.value;
    *blue = self.blueSlider.value;
}

- (void)command:(DCSetStrokeColorCommand *)command didFinishColorUpdateWithColor:(UIColor *)color {
    self.paletteView.backgroundColor = color;
}

#pragma mark SetStrokeSizeCommandDelegate method

- (void)command:(DCSetStrokeSizeCommand *)command didRequestForStrokeSize:(CGFloat *)size {
    *size = self.sizeSlider.value;
}

#pragma mark -
#pragma mark Slider event handler

- (IBAction)onCommandSliderValueChanged:(DCCommandSlider *)slider {
    [[slider command] execute];
}

@end
