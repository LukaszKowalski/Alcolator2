//
//  BLCWhiskeyViewController.h
//  Alcolator2
//
//  Created by Łukasz Kowalski on 7/12/14.
//  Copyright (c) 2014 Lukasz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BLCWhiskeyViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;
@property (strong, nonatomic) NSString *beerText;

- (void)buttonPressed:(UIButton *)sender;


@end
