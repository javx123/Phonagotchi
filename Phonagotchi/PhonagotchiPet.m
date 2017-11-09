
//
//  PhonagotchiPet.m
//  Phonagotchi
//
//  Created by Javier Xing on 2017-11-09.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "PhonagotchiPet.h"

@interface PhonagotchiPet()
@property (nonatomic, assign, readwrite) BOOL isGrumpy;
@end

@implementation PhonagotchiPet
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isGrumpy = NO;
        _isAsleep = NO;
        _restfulness = 10;
    }
    return self;
}


-(void)petPhonagotchi:(CGPoint)velocity{
    if ((velocity.x >= (50*self.restfulness)) || (velocity.y >= (50*self.restfulness))) {
        self.isGrumpy = YES;
        
}
    else{
        self.isGrumpy = NO;
    }
}

-(void)sleepSchedule{
    if(!self.isAsleep){
        self.restfulness--;
    }
    else if (self.isAsleep){
        self.restfulness++;
    }
    
    
    if (self.restfulness == 0) {
        self.isAsleep = YES;
    }
    else if (self.restfulness == 10){
        self.isAsleep = NO;
    }
}




@end
