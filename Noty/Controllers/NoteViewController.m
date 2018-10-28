//
//  NoteViewController.m
//  Noty
//
//  Created by Ruslan Arhypenko on 10/17/18.
//  Copyright © 2018 Ruslan Arhypenko. All rights reserved.
//

#import "NoteViewController.h"
#import "Note.h"

@interface NoteViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundWall"]];
    self.noteTextView.keyboardAppearance = UIKeyboardAppearanceDark;
    self.noteTextView.alwaysBounceVertical = YES;
    
    self.noteTextView.text = self.note.content;

    NSDate *currentDate = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM d yyyy, HH:mm"];
    NSString *currentDateString = [outputFormatter stringFromDate:currentDate];
    
    self.dateLabel.text = currentDateString;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.noteTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *currentDateString = [outputFormatter stringFromDate:currentDate];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedString = [self.noteTextView.text stringByTrimmingCharactersInSet:charSet];

    if (self.note != nil && ![trimmedString isEqualToString:@""]) {
        self.note.date = currentDateString;
        self.note.content = self.noteTextView.text;
        [self.delegate sendNoteToMainVC:self.note];

    } else if (![trimmedString isEqualToString:@""]){
        Note* note = [[Note alloc] init];
        note.date = currentDateString;
        note.content = self.noteTextView.text;
        note.index = -99;
        [self.delegate sendNoteToMainVC:note];
    }
    
    [self.noteTextView resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.noteTextView resignFirstResponder];
}

@end
