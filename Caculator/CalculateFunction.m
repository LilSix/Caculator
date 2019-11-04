//
//  CalculateFunction.m
//  Caculator
//
//  Created by YU-CHEN LIN on 2019/11/3.
//  Copyright © 2019 YU-CHEN LIN. All rights reserved.
//

#import "CalculateFunction.h"

@implementation CalculateFunction

- (NSNumber *)plusCaculate:(NSNumber *)addend
                    augend:(NSNumber *)augend {
    NSDecimalNumber *x = [NSDecimalNumber decimalNumberWithString:[addend stringValue]];
    NSDecimalNumber *y = [NSDecimalNumber decimalNumberWithString:[augend stringValue]];
    return [x decimalNumberByAdding:y];
}

- (NSNumber *)minusCaculate:(NSNumber *)minuend
                 subtrahend:(NSNumber *)subtrahend {
    NSDecimalNumber *x = [NSDecimalNumber decimalNumberWithString:[minuend stringValue]];
    NSDecimalNumber *y = [NSDecimalNumber decimalNumberWithString:[subtrahend stringValue]];
    return [x decimalNumberBySubtracting:y];
}

- (NSNumber *)timesCaculate:(NSNumber *)multiplicand
                 multiplier:(NSNumber *)multiplier {
    NSDecimalNumber *x = [NSDecimalNumber decimalNumberWithString:[multiplicand stringValue]];
    NSDecimalNumber *y = [NSDecimalNumber decimalNumberWithString:[multiplier stringValue]];
    return [x decimalNumberByMultiplyingBy:y];
}

- (NSNumber *)divisionCaculate:(NSNumber *)dividend
                       divisor:(NSNumber *)divisor {
    if ([divisor isEqualToNumber:@(0)]) {
        return divisor;
    }
    NSDecimalNumber *x = [NSDecimalNumber decimalNumberWithString:[dividend stringValue]];
    NSDecimalNumber *y = [NSDecimalNumber decimalNumberWithString:[divisor stringValue]];
    return [x decimalNumberByDividingBy:y];
}

@end
