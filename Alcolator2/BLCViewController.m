//
//  BLCViewController.m
//  Alcolator2
//
//  Created by Łukasz Kowalski on 7/11/14.
//  Copyright (c) 2014 Lukasz. All rights reserved.
//

#import "BLCViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface BLCViewController () <UITextFieldDelegate, UITabBarControllerDelegate>

@property (weak, nonatomic) UILabel *numberOfBeersFromSlider;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;


@end

@implementation BLCViewController
-(void)loadView {
    
    self.view = [UIView new];
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Vodka";
	self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -20)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} forState:UIControlStateNormal];
    // TextField
    
    
    
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.tag = 1;
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    self.beerPercentTextField.layer.cornerRadius = 8.0f;
    self.beerPercentTextField.layer.masksToBounds = YES;
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    // I would like to centre only a placeholder - not the beer count.
    
    // Slider
    
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.maximumValue = 10;
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.minimumTrackTintColor = [UIColor blackColor];

    // button
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.backgroundColor = [UIColor whiteColor];
    self.calculateButton.layer.cornerRadius = 20;
    [self.calculateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureRecognizer:)];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.text = @"Click calculate after filling how much alcohol was in your beer";
    
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = 320;
    CGFloat padding = 20;
    CGFloat itemHight = 44;
    CGFloat itemWidht = viewWidth - padding - padding;
    
    self.beerPercentTextField.frame = CGRectMake(20, 40, itemWidht, itemHight);
    CGFloat buttomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    
    self.beerCountSlider.frame = CGRectMake(padding, buttomOfTextField + padding, itemWidht, itemHight );
    CGFloat buttomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    
    self.resultLabel.frame = CGRectMake(padding, buttomOfSlider + padding, itemWidht, itemHight * 4);
    CGFloat buttomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    
    self.calculateButton.frame = CGRectMake(padding, buttomOfLabel + padding , itemWidht, itemHight);
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 - (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if ( enteredNumber == 0) {
        sender.text = nil;
    }
    
}
- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider Value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int)sender.value]];

    }

- (void)buttonPressed:(UIButton *)sender {
    
    NSLog(@"%@", self.resultLabel.text);
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 18;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] /100;
    float ouncesOfAlcoholInOneBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfTotalAlcohol = ouncesOfAlcoholInOneBeer * numberOfBeers;
    
    float ouncesInOneShot = 2;
    float alcoholPercentageOfVodka = 0.4;
    
    float ouncesOfAlcoholPerOneShot = ouncesInOneShot * alcoholPercentageOfVodka;
    float numberOfShotsEquivalentAlcoholAmount = ouncesOfTotalAlcohol / ouncesOfAlcoholPerOneShot;
    
    if (numberOfBeers == 1 ) {
        self.beerText = NSLocalizedString(@"beer", @"singular beer");
    }else{
        self.beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    NSString *shotText;
    if (numberOfShotsEquivalentAlcoholAmount == 1) {
        shotText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        shotText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of vodka.", nil), numberOfBeers, self.beerText, numberOfShotsEquivalentAlcoholAmount, shotText];
    self.resultLabel.text = resultText;
   
    
}

- (void)tapGestureRecognizer:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   
    NSLog(@"hej lamusy, zmienilem sie jestem w WC");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ( [self.title isEqualToString:@"Vodka"]) {
        NSLog (@"%@", self.title);
    }
    
    return YES;
}


@end