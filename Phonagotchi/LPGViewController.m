//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "PhonagotchiPet.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *basketImageView;
@property (nonatomic) UIImageView *duplicateApple;
@property (nonatomic) AVAudioPlayer * meowSound;

@property (nonatomic, strong)PhonagotchiPet * pet;


@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];

    
    self.pet = [[PhonagotchiPet alloc]init];
    
//    The pet image
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default-1"];
    
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;

    //    The Basket image
    self.basketImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.basketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.basketImageView.image = [UIImage imageNamed:@"bucket"];
    [self.view addSubview:self.basketImageView];
    
    [NSLayoutConstraint constraintWithItem:self.basketImageView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.basketImageView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.basketImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:90.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.basketImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:90.0].active = YES;
    
//    The apple image
    
    self.appleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    [self.view addSubview:self.appleImageView];
    
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.basketImageView
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0
                                  constant:10.0].active = YES;

    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.basketImageView
                                 attribute:NSLayoutAttributeBottomMargin
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.appleImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50.0].active = YES;

//    Implementation
    self.petImageView.userInteractionEnabled =YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]init];
    [pan addTarget:self action:@selector(petPhonogotchi:)];
    [self.petImageView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(petMeow)];
    doubleTap.numberOfTapsRequired = 2;
    [self.petImageView addGestureRecognizer:doubleTap];
    
    self.appleImageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]init];
    [self.appleImageView addGestureRecognizer:pinch];
    [pinch addTarget:self action:@selector(grabApple:)];
    
    
     __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkSleep) userInfo:nil repeats:YES];
}

-(void)petPhonogotchi:(UIPanGestureRecognizer*)pan {
    CGPoint newPoint = [pan velocityInView:self.petImageView];
        [self.pet petPhonagotchi:newPoint];
        [self checkMood];
}

-(void)grabApple:(UIPinchGestureRecognizer*)pinch {
    
    CGPoint appleLocation = [pinch locationInView:self.view];
    if (pinch.state == UIGestureRecognizerStateBegan) {
        self.duplicateApple = [[UIImageView alloc]init];
        self.duplicateApple.userInteractionEnabled = YES;
        self.duplicateApple.image = [UIImage imageNamed:@"apple"];
        CGPoint appleLocation = [pinch locationInView:self.view];
        self.duplicateApple.frame = CGRectMake(appleLocation.x, appleLocation.y, 50, 50);
        [self.view addSubview:self.duplicateApple];
        
    } else if (pinch.state == UIGestureRecognizerStateChanged) {
        CGPoint appleLocation = [pinch locationInView:self.view];
        NSLog(@"The location of it is %@", NSStringFromCGPoint(appleLocation));

        
        self.duplicateApple.center = appleLocation;
    }
    else if (pinch.state == UIGestureRecognizerStateEnded){

        if (CGRectContainsPoint(self.petImageView.frame, appleLocation)) {
            [UIView animateWithDuration:0.5
        animations:^(void){
            self.duplicateApple.frame = CGRectMake(appleLocation.x, appleLocation.y, 0.0, 0.0);
        }
        completion:^(BOOL finished){
            [self.duplicateApple removeFromSuperview];
        }];
        }
        else{
        CGPoint appleLocation = [pinch locationInView:self.view];
        [UIView animateWithDuration:1.0
                         animations:^(void){
                             self.duplicateApple.center = CGPointMake(appleLocation.x, 600.0);
                         }
                         completion:^(BOOL finished){
                             [self.duplicateApple removeFromSuperview];
                         }];
        }
    }
}

-(void)checkMood{
    if (self.pet.isGrumpy){
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    }
    else{
        self.petImageView.image = [UIImage imageNamed:@"default-1"];
    }
}

-(void)checkSleep{
    [self.pet sleepSchedule];
    if (self.pet.isAsleep) {
        self.petImageView.image = [UIImage imageNamed:@"sleeping"];
    }
    else{
        self.petImageView.image = [UIImage imageNamed:@"default-1"];
    }
}

-(void)petMeow{

    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"meow.mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    NSError *err = nil;
    self.meowSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:&err];
    [self.meowSound play];
    NSLog(@"Meow %@", err);
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.type == UIEventSubtypeMotionShake) {
        self.pet.isAsleep = NO;
    }
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}





@end
