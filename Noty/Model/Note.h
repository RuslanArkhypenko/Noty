//
//  Note.h
//  Noty
//
//  Created by Ruslan Arhypenko on 10/13/18.
//  Copyright © 2018 Ruslan Arhypenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* date;

@end

NS_ASSUME_NONNULL_END
