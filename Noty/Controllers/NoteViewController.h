//
//  NoteViewController.h
//  Noty
//
//  Created by Ruslan Arhypenko on 10/17/18.
//  Copyright © 2018 Ruslan Arhypenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NoteInfoDelegate <NSObject>

- (void)sendNoteToMainVC:(Note*) note;

@end

@interface NoteViewController : UIViewController

@property (strong, nonatomic) Note* note;

@property (weak, nonatomic) id <NoteInfoDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
