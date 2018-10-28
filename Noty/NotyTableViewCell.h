//
//  NotyTableViewCell.h
//  Noty
//
//  Created by Ruslan Arhypenko on 10/13/18.
//  Copyright © 2018 Ruslan Arhypenko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
