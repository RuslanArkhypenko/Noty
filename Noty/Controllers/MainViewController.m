//
//  MainTableViewController.m
//  Noty
//
//  Created by Ruslan Arhypenko on 10/13/18.
//  Copyright © 2018 Ruslan Arhypenko. All rights reserved.
//

#import "MainViewController.h"
#import "NotyTableViewCell.h"
#import "NoteViewController.h"

@interface MainViewController () <NoteInfoDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) NSMutableArray* noteArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundWall"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.noteArray = [NSMutableArray new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return MAX(self.noteArray.count, 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.noteArray.count == 0) {
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        [self customCellSelection:cell];
        
        if (tableView.editing) {
            
            [self.tableView setEditing:NO];
            [self.editButton setTitle:@"Edit"];
        }
        
        return cell;
    } else {
        
        NotyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
        
        Note* note = [self.noteArray objectAtIndex:indexPath.row];
        
        NSString* trimmedContent = [note.content stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
     
        cell.imageLabel.text = [trimmedContent substringToIndex:1];
        cell.contentLabel.text = trimmedContent;
        cell.dateLabel.text = note.date;
        
        [self customCellSelection:cell];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.noteArray.count > 0 ? YES : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.noteArray removeObjectAtIndex:indexPath.row];

        if (self.noteArray.count > 0) {
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
        } else {
            [tableView reloadData];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NoteInfoDelegate

- (void)sendNoteToMainVC:(Note *)note {
        
    if (note.index >= 0) {
        [self.noteArray replaceObjectAtIndex:note.index withObject:note];
    } else {
        [self.noteArray insertObject:note atIndex:0];
    }
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NotyTableViewCell *)cell {
    
    NoteViewController* noteVC = (NoteViewController*)segue.destinationViewController;
    [noteVC setDelegate:self];
    
    if ([segue.identifier isEqualToString:@"NotyTableViewCell"]) {

        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        
        Note* note = [self.noteArray objectAtIndex:indexPath.row];
        note.index = indexPath.row;
        
        noteVC.note = note;
    }
}

- (void)customCellSelection:(UITableViewCell*)cell {
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:218/255.0
                                                      green:34/255.0
                                                       blue:68/255.0
                                                      alpha:0.75];
    cell.selectedBackgroundView =  customColorView;
}

#pragma mark - Actions

- (IBAction)editAction:(UIBarButtonItem *)sender {
    
    BOOL isEditing = self.tableView.editing;
    
    if (!isEditing && self.noteArray.count > 0) {
        [self.tableView setEditing:YES animated:YES];
        sender.title = @"Done";
    } else {
        [self.tableView setEditing:NO animated:YES];
        sender.title = @"Edit";
    }
}

@end
