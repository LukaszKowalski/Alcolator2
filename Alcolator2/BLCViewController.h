//
//  BLCViewController.h
//  Alcolator2
//
//  Created by Łukasz Kowalski on 7/11/14.
//  Copyright (c) 2014 Lukasz. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BLCWhiskeyViewController;

@interface BLCViewController : UIViewController <UITabBarControllerDelegate>

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;
@property (strong, nonatomic) NSString *beerText;


- (void)buttonPressed:(UIButton *)sender;

@end
