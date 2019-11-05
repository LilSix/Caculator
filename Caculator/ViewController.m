//
//  ViewController.m
//  Caculator
//
//  Created by YU-CHEN LIN on 2019/10/31.
//  Copyright © 2019 YU-CHEN LIN. All rights reserved.
//

#import "ViewController.h"
#import "CalculateFunction.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *num1Button;
@property (weak, nonatomic) IBOutlet UIButton *num2Button;
@property (weak, nonatomic) IBOutlet UIButton *num3Button;
@property (weak, nonatomic) IBOutlet UIButton *num4Button;
@property (weak, nonatomic) IBOutlet UIButton *num5Button;
@property (weak, nonatomic) IBOutlet UIButton *num6Button;
@property (weak, nonatomic) IBOutlet UIButton *num7Button;
@property (weak, nonatomic) IBOutlet UIButton *num8Button;
@property (weak, nonatomic) IBOutlet UIButton *num9Button;
@property (weak, nonatomic) IBOutlet UIButton *num0Button;
@property (weak, nonatomic) IBOutlet UIButton *dotButton;
@property (weak, nonatomic) IBOutlet UIButton *equalButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *timesButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *percentButton;
@property (weak, nonatomic) IBOutlet UIButton *divisionButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (strong, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) NSNumber *numberX;
@property (strong, nonatomic) NSNumber *numberY;
@property (copy, nonatomic) NSString *decimalStringX;
@property (copy, nonatomic) NSString *decimalStringY;
@property (assign, nonatomic) Operation selectedOperation;
@property (strong, nonatomic) CalculateFunction *calculateFunction;
@property (assign, nonatomic, getter=isDecimalNumber) BOOL decimalNumber;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _calculateFunction = [[CalculateFunction alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.decimalNumber = NO;
    self.numberX = @(0);
    self.numberY = @(0);
    self.decimalStringX = [[NSString alloc] init];
    self.decimalStringY = [[NSString alloc] init];
    self.selectedOperation = noneOperation;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setButtonCircleShape:self.num1Button];
    [self setButtonCircleShape:self.num2Button];
    [self setButtonCircleShape:self.num3Button];
    [self setButtonCircleShape:self.num4Button];
    [self setButtonCircleShape:self.num5Button];
    [self setButtonCircleShape:self.num6Button];
    [self setButtonCircleShape:self.num7Button];
    [self setButtonCircleShape:self.num8Button];
    [self setButtonCircleShape:self.num9Button];
    [self setButtonCircleShape:self.num0Button];
    [self setButtonCircleShape:self.dotButton];
    [self setButtonCircleShape:self.equalButton];
    [self setButtonCircleShape:self.plusButton];
    [self setButtonCircleShape:self.minusButton];
    [self setButtonCircleShape:self.timesButton];
    [self setButtonCircleShape:self.clearButton];
    [self setButtonCircleShape:self.percentButton];
    [self setButtonCircleShape:self.divisionButton];
}

#pragma mark - Adjust user interface

- (void)setButtonCircleShape:(UIButton *)button {
    button.layer.cornerRadius = button.frame.size.height / 2;
}

#pragma mark - UIButton action

- (IBAction)numberButtonTouched:(UIButton *)sender {
    if (self.answerLabel.text.length > 9) {
        return;
    }
    
    if ([self.numberX isEqualToNumber:@(0)] &&
        sender.tag == 0 &&
        self.isDecimalNumber == NO) {
        return;
    }
    
    if (self.selectedButton != nil) {
        [self setButton:self.selectedButton
            highlighted:NO];
    }
    
    if (self.selectedOperation == noneOperation) {
        // 被計算數
        if (self.isDecimalNumber == NO) {
            // 沒有小數點
            self.numberX = [NSDecimalNumber numberWithInteger:[self.numberX integerValue] * 10 + sender.tag];
            self.answerLabel.text = [self.numberX stringValue];
        } else {
            // 有小數點
            
            self.decimalStringX = [NSString stringWithFormat:@"%@%ld", self.decimalStringX, sender.tag];
            self.answerLabel.text = [NSString stringWithFormat:@"%@.%@", [self.numberX stringValue], self.decimalStringX];
        }
    } else {
        // 計算數
        if (self.isDecimalNumber == NO) {
            // 沒有小數點
            self.numberY = [NSDecimalNumber numberWithInteger:[self.numberY integerValue] * 10 + sender.tag];
            self.answerLabel.text = [self.numberY stringValue];
        } else {
            // 有小數點
            self.decimalStringY = [NSString stringWithFormat:@"%@%ld", self.decimalStringY, sender.tag];
            self.answerLabel.text = [NSString stringWithFormat:@"%@.%@", [self.numberY stringValue], self.decimalStringY];
        }
    }
    [self.clearButton setTitle:@"C"
                      forState:UIControlStateNormal];
}

- (IBAction)dotButtonTouched:(UIButton *)sender {
    if (self.isDecimalNumber == NO) {
        self.decimalNumber = YES;
        if (self.selectedOperation == noneOperation) {
            self.answerLabel.text = [NSString stringWithFormat:@"%@.", self.answerLabel.text];
        } else {
            self.answerLabel.text = [NSString stringWithFormat:@"%@.", [self.numberY stringValue]];
        }
    }
}

- (IBAction)equalButtonTouched:(UIButton *)sender {
    [self calculateAnswerWithOperation:self.selectedOperation];
}

- (IBAction)plusButtonTouched:(UIButton *)sender {
    [self setButton:sender
        highlighted:YES];
    [self calculateAnswerWithOperation:plusOperation];
    [self showAnswerFromNumber:self.numberX];
}

- (IBAction)minusButtonTouched:(UIButton *)sender {
    [self setButton:sender
        highlighted:YES];
    [self calculateAnswerWithOperation:minusOperation];
}

- (IBAction)timesButtonTouched:(UIButton *)sender {
    [self setButton:sender
        highlighted:YES];
    [self calculateAnswerWithOperation:timesOperation];
}

- (IBAction)divisionButtonTouched:(UIButton *)sender {
    [self setButton:sender
        highlighted:YES];
    [self calculateAnswerWithOperation:divisionOperation];
}

- (IBAction)percentButtonTouched:(UIButton *)sender {
    [self calculateAnswerWithOperation:percentOperation];
}

- (IBAction)clearButtonTouched:(UIButton *)sender {
    [self calculateAnswerWithOperation:noneOperation];
    [sender setTitle:@"AC"
            forState:UIControlStateNormal];
    [self setButton:self.selectedButton
        highlighted:NO];
}

#pragma mark - Private calculate function

- (void)calculateAnswerWithOperation:(Operation)operation {
    // 運算前先將整數與小數加總
    if (self.isDecimalNumber == YES) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        self.decimalStringX = [NSString stringWithFormat:@"0.%@", self.decimalStringX];
        NSNumber *decimalNumberX = [numberFormatter numberFromString:self.decimalStringX];
        self.numberX = @([self.numberX doubleValue] + [decimalNumberX doubleValue]);
        self.decimalStringX = @"";
        self.decimalStringY = [NSString stringWithFormat:@"0.%@", self.decimalStringY];
        NSNumber *decimalNumberY = [numberFormatter numberFromString:self.decimalStringY];
        self.numberY = @([self.numberY doubleValue] + [decimalNumberY doubleValue]);
        self.decimalStringY = @"";
    }
    
    // 變換運算符號時，先將前一符號做運算
    if (self.selectedOperation != noneOperation &&
        self.selectedOperation != percentOperation &&
        self.selectedOperation != operation) {
            [self calculateAnswerWithOperation:self.selectedOperation];
        if (operation == timesOperation ||
            operation == divisionOperation) {
            self.numberY = @(1);
        }
    }
    
    switch (operation) {
        case plusOperation:
            self.numberX = [self.calculateFunction plusCaculate:self.numberX
                                                         augend:self.numberY];
            break;
        case minusOperation:
            self.numberX = [self.calculateFunction minusCaculate:self.numberX
                                                      subtrahend:self.numberY];
            break;
        case timesOperation:
            if (self.selectedOperation == noneOperation) {
                self.numberY = @(1);
            }
            self.numberX = [self.calculateFunction timesCaculate:self.numberX
                                                      multiplier:self.numberY];
            break;
        case divisionOperation:
            if ([self.numberY isEqualToNumber:@(0)]) {
                break;
            }
            if (self.selectedOperation == noneOperation) {
                self.numberY = @(1);
            }
            self.numberX = [self.calculateFunction divisionCaculate:self.numberX
                                                            divisor:self.numberY];
            break;
        case percentOperation:
            self.numberX = @([self.numberX doubleValue] / 100);
            break;
        case noneOperation:
            self.numberX = @(0);
            self.decimalStringX = @"";
            self.decimalStringY = @"";
            break;
    }
    if (operation == percentOperation) {
        self.decimalNumber = YES;
    } else {
        self.decimalNumber = NO;
    }
    self.numberY = @(0);
    self.selectedOperation = operation;
    [self showAnswerFromNumber:self.numberX];
}

#pragma mark - UIButton highlight

- (void)setButton:(UIButton *)sender
      highlighted:(BOOL)highlighted {
    // 判斷前一按鈕是否已被選取
    if (self.selectedButton != nil &&
        self.selectedButton != sender) {
        [self setButton:self.selectedButton
            highlighted:NO];
    }
    if (highlighted == YES) {
        sender.backgroundColor = UIColor.whiteColor;
        [sender setTitleColor:UIColor.orangeColor
                     forState:UIControlStateNormal];
        self.selectedButton = sender;
    } else {
        sender.backgroundColor = UIColor.orangeColor;
        [sender setTitleColor:UIColor.whiteColor
                     forState:UIControlStateNormal];
        self.selectedButton = nil;
    }
}

#pragma mark - Show answer label

- (void)showAnswerFromNumber:(NSNumber *)number {
    NSString *doubleValueString = [NSString stringWithFormat:@"%f", [number doubleValue]];
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:doubleValueString];
    self.answerLabel.alpha = 0.0;
    [UIView animateWithDuration:0.1
                     animations:^{
        self.answerLabel.text = [decimalNumber stringValue];
        self.answerLabel.alpha = 1.0;
    }];
}

@end
