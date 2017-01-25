//
//  ProfileCell.m
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import "ProfileCell.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ProfileCell ()

@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *ageRangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *timezoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;

@end

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setUserData:(NSDictionary *)userData {
    NSLog(@"user data: %@", userData);
    self.profilePicture.profileID = userData[@"id"];
    if (userData[@"age_range"]) {
        self.ageRangeLabel.text = [NSString stringWithFormat:@"%@+", userData[@"age_range"][@"min"]];
    } else {
        self.fullNameLabel.text = NSLocalizedString(@"N/A", nil);
    }
    if (userData[@"gender"]) {
        self.genderLabel.text = userData[@"gender"];
    } else {
        self.fullNameLabel.text = NSLocalizedString(@"N/A", nil);
    }
    if (userData[@"timezone"]) {
        self.timezoneLabel.text = [NSString stringWithFormat:@"GMT %@h", userData[@"timezone"]];
    } else {
        self.fullNameLabel.text = NSLocalizedString(@"N/A", nil);
    }
    if (userData[@"first_name"] && userData[@"last_name"]) {
        self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", userData[@"first_name"], userData[@"last_name"]];
    } else {
        self.fullNameLabel.text = NSLocalizedString(@"N/A", nil);
    }

}

@end
