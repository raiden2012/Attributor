//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Wei Tu on 2/1/2016.
//  Copyright © 2016 Wei Tu. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void)updateUI {
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)range.location + (int)range.length;
        } else {
            index ++;
        }
    }
    
    return characters;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName : [UIColor greenColor], NSStrokeWidthAttributeName : @-3} ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
