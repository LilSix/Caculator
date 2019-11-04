//
//  CalculateFunction.h
//  Caculator
//
//  Created by YU-CHEN LIN on 2019/11/3.
//  Copyright © 2019 YU-CHEN LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    noneOperation,
    plusOperation,
    minusOperation,
    timesOperation,
    divisionOperation,
    percentOperation
} Operation;

@interface CalculateFunction : NSObject

- (NSNumber *)plusCaculate:(NSNumber *)addend
                    augend:(NSNumber *)augend;          // 加法
- (NSNumber *)minusCaculate:(NSNumber *)minuend
                 subtrahend:(NSNumber *)subtrahend;     // 減法
- (NSNumber *)timesCaculate:(NSNumber *)multiplicand
                 multiplier:(NSNumber *)multiplier;     // 乘法
- (NSNumber *)divisionCaculate:(NSNumber *)dividend
                       divisor:(NSNumber *)divisor;     // 除法

@end
