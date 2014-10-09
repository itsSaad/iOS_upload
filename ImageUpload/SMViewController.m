//
//  SMViewController.m
//  ImageUpload
//
//  Created by Saad Masood on 10/4/14.
//  Copyright (c) 2014 Saad Masood. All rights reserved.
//

#import "SMViewController.h"
#import "SMPhoto.h"

@interface SMViewController ()

@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) NSArray * photos;

- (IBAction)chooseNewPhoto:(id)sender;


@end

@implementation SMViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.photos = [NSArray array];
    
    [self getPhotosFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseNewPhoto:(id)sender
{
    NSLog(@"UIBar Button Tapped");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void) getPhotosFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@apiGetAllPhotos parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject)
    {
        NSLog(@"Success");
        self.photos = [SMPhoto createPhotoFromDict:responseObject];
        [self.tableView reloadData];
    }
     failure:^(AFHTTPRequestOperation *operation, NSError * error)
    {
         NSLog(@"Failure");
    }];
}







#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * aCell = [tableView dequeueReusableCellWithIdentifier:@"photo_cell"];
    if (!aCell)
    {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"photo_cell"];
    }
    SMPhoto * aPhoto = [self.photos objectAtIndex:indexPath.row];
    
    UILabel * title = (UILabel *)[aCell.contentView viewWithTag:56];
    UIImageView * imageView = (UIImageView *)[aCell.contentView viewWithTag:55];
    title.text = aPhoto.title;
    [imageView loadImageFromURL:aPhoto.imageURL placeholderImage:nil cachingKey:aPhoto.fileName];
    
    return aCell;
}










#pragma - mark UIImagePickerView Delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Image Pick Complete");
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Canceled Picking Image");
}



@end
