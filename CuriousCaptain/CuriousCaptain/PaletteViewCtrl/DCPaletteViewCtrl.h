//
//  DCPaletteViewCtrl.h
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCommandBarButton.h"
#import "DCCommandSlider.h"
#import "DCSetStrokeColorCommand.h"
#import "DCSetStrokeSizeCommand.h"

@interface DCPaletteViewCtrl : UIViewController <DCSetStrokeColorCommandDelegate, DCSetStrokeSizeCommandDelegate>

@property (retain, nonatomic) IBOutlet UILabel *colorTilteLabel;
@property (retain, nonatomic) IBOutlet UILabel *sizeTitleLabel;
@property (retain, nonatomic) IBOutlet DCCommandSlider *redSlider;
@property (retain, nonatomic) IBOutlet DCCommandSlider *greenSlider;
@property (retain, nonatomic) IBOutlet DCCommandSlider *blueSlider;
@property (retain, nonatomic) IBOutlet UIView *paletteView;
@property (retain, nonatomic) IBOutlet DCCommandSlider *sizeSlider;

- (IBAction)onCommandSliderValueChanged:(DCCommandSlider *)slider;

@end
