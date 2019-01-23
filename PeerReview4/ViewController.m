//
//  ViewController.m
//  PeerReview4
//
//  Created by Ananta Shahane on 26/04/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *SourceLocation;
@property (weak, nonatomic) IBOutlet UITextField *DestinationA;
@property (weak, nonatomic) IBOutlet UITextField *DestinationB;
@property (weak, nonatomic) IBOutlet UITextField *DestinationC;
@property (weak, nonatomic) IBOutlet UILabel *DistanceA;
@property (weak, nonatomic) IBOutlet UILabel *DistanceB;
@property (weak, nonatomic) IBOutlet UILabel *DistanceC;
@property (weak, nonatomic) IBOutlet UISegmentedControl *UnitController;

@property (weak, nonatomic) IBOutlet UIButton *CalculateButton;

@end

@implementation ViewController

- (IBAction)CalculateButton:(id)sender {
    self.CalculateButton.enabled = NO;
    NSString *source = self.SourceLocation.text;
    NSString *destinationA = self.DestinationA.text;
    NSString *destinationB = self.DestinationB.text;
    NSString *destinationC = self.DestinationC.text;
    NSArray *dests = @[destinationA, destinationB, destinationC];
    self.req = [DGDistanceRequest alloc];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:source];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        NSNull *badResult = [NSNull null];
        
        if (responses[0] != badResult) {
            double number = ([responses[0] floatValue]);
            if (strongSelf.UnitController.selectedSegmentIndex == 0) {
                NSString *x = [NSString stringWithFormat:@"%.2f m", number];
                strongSelf.DistanceA.text = x;
            }
            else if(strongSelf.UnitController.selectedSegmentIndex == 1)
            {
                double kms = number/1000;
                NSString *x = [NSString stringWithFormat:@"%.2lf km", kms];
                weakSelf.DistanceA.text = x;
            }
            else
            {
                double miles = number/1609.34;
                NSString *x = [NSString stringWithFormat:@"%.2lf miles", miles];
                weakSelf.DistanceA.text = x;
            }
            
        }
        else
        {
            NSString *x = @"Unknown Distance";
            weakSelf.DistanceA.text = x;
            
        }
        if (responses[1] != badResult) {
            double number = ([responses[1] floatValue]);
            if (strongSelf.UnitController.selectedSegmentIndex == 0) {
                NSString *x = [NSString stringWithFormat:@"%.2f m", number];
                strongSelf.DistanceB.text = x;
            }
            else if(strongSelf.UnitController.selectedSegmentIndex == 1)
            {
                double kms = number/1000;
                NSString *x = [NSString stringWithFormat:@"%.2lf km", kms];
                weakSelf.DistanceB.text = x;
            }
            else
            {
                double miles = number/1609.34;
                NSString *x = [NSString stringWithFormat:@"%.2lf miles", miles];
                weakSelf.DistanceB.text = x;
            }
        }
        else
        {
            NSString *x = @"Unknown Distance";
            weakSelf.DistanceB.text = x;
            
        }
        if (responses[2] != badResult) {
            double number = ([responses[2] floatValue]);
            if (strongSelf.UnitController.selectedSegmentIndex == 0) {
                NSString *x = [NSString stringWithFormat:@"%.2f m", number];
                strongSelf.DistanceC.text = x;
            }
            else if(strongSelf.UnitController.selectedSegmentIndex == 1)
            {
                double kms = number/1000;
                NSString *x = [NSString stringWithFormat:@"%.2lf km", kms];
                weakSelf.DistanceC.text = x;
            }
            else
            {
                double miles = number/1609.34;
                NSString *x = [NSString stringWithFormat:@"%.2lf miles", miles];
                weakSelf.DistanceC.text = x;
            }
        }
        else
        {
            NSString *x = @"Unknown Distance";
            weakSelf.DistanceC.text = x;
            
        }
        strongSelf.CalculateButton.enabled = YES;
        strongSelf.req = nil;
        
    };
    [self.req start];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
