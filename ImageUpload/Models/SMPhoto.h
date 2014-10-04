//
//  SMPhoto.h
//  ImageUpload
//
//  Created by Saad Masood on 10/4/14.
//  Copyright (c) 2014 Saad Masood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMPhoto : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) NSString * fileName;
@property (strong, nonatomic) NSDate * uploadedAt;
@property (strong, nonatomic) NSURL * imageURL;

+(NSArray *) createPhotoFromDict:(NSDictionary *)dict;

@end
