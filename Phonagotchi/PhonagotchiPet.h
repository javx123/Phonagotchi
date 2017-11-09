//
//  PhonagotchiPet.h
//  Phonagotchi
//
//  Created by Javier Xing on 2017-11-09.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhonagotchiPet : NSObject

@property (nonatomic, assign, readonly) BOOL isGrumpy;
@property (nonatomic,assign) BOOL isAsleep;
@property (nonatomic,assign) int restfulness;

-(void)petPhonagotchi:(CGPoint)velocity;
-(void)sleepSchedule;



@end
