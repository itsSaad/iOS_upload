//
//  SMPhoto.m
//  ImageUpload
//
//  Created by Saad Masood on 10/4/14.
//  Copyright (c) 2014 Saad Masood. All rights reserved.
//

#import "SMPhoto.h"

@implementation SMPhoto

+(NSArray *) createPhotoFromDict:(NSDictionary *)dict
{
    NSArray * allPhotoDict = dict[@"photos"];
    NSMutableArray * allPhotos = [[NSMutableArray alloc]init];
    for (NSDictionary * aPhotoDict in allPhotoDict)
    {
        SMPhoto *aPhoto = [[SMPhoto alloc]init];
        aPhoto.title = aPhotoDict[@"title"];
        
        aPhoto.fileName = aPhotoDict[@"image_file_name"];
        NSString * tempURL = aPhotoDict[@"url"];
        NSURL * url = nil;
        if (![tempURL containsString:@"http"])
        {
            url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",@ServerBaseURL, tempURL]];
        }
        else
        {
            url = [[NSURL alloc] initWithString:tempURL];
        }
        
        aPhoto.imageURL = url;
        [allPhotos addObject:aPhoto];
    }
    
    return allPhotos;
}


-(NSString *) description
{
    return [NSString stringWithFormat:@"\nImage Title: %@\nImage File Name: %@\nImage URL: %@", self.title, self.fileName, self.imageURL];
    
}

@end
