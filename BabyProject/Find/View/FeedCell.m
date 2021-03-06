//
//  FeedCell.m
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (void)awakeFromNib {
    // Initialization code
    self.headPicImgV.layer.masksToBounds = YES;
    self.headPicImgV.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FeedModel *)model{
    
    [self.headPicImgV sd_setImageWithURL:[NSURL URLWithString:model.creatorHeadPic] placeholderImage:nil options:SDWebImageRefreshCached];
    self.nickNameLabel.text = model.creatorNickName;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil options:SDWebImageRefreshCached];
    self.cityLabel.text = [NSString stringWithFormat:@"%@%@", model.city, model.region];
    self.titleLabel.text = model.addonTitles;
    
    //计算年龄
    self.ageLabel.text = [self getAge:model.babyBirthday];
    
    self.dateLabel.text = [self getTime:model.createDate];
    
    
}

//计算年龄
- (NSString *)getAge:(NSString *)birthDay{
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    //生日
    NSInteger bit = [birthDay  integerValue];
    NSDate *birthTime = [NSDate dateWithTimeIntervalSince1970:bit/1000];
    
    //用来得到具体的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthTime toDate:nowDate options:0];
    
    if([date year] >0) {
        //NSLog(@"%@",[NSString stringWithFormat:(@"%ld岁"),(long)[date year]]) ;
        return   [NSString stringWithFormat:(@"%ld岁"),(long)[date year]];
    } else if([date month] >0) {
        //NSLog(@"%@",[NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]]);
        return   [NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]];
        
    } else if([date day]>0){
        //NSLog(@"%@",[NSString stringWithFormat:(@"%ld天"),(long)[date day]]); } else { NSLog(@"0天");
        return   [NSString stringWithFormat:(@"%ld天"),(long)[date day]];
    }
    return nil;
}

- (NSString *)getTime:(NSString *)createTime{
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    //生日
    NSInteger bit = [createTime  integerValue];
    NSDate *birthTime = [NSDate dateWithTimeIntervalSince1970:bit/1000];
    
    //用来得到具体的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthTime toDate:nowDate options:0];
    
    if([date year] >0) {
        //NSLog(@"%@",[NSString stringWithFormat:(@"%ld岁"),(long)[date year]]) ;
        return   [NSString stringWithFormat:(@"%ld年前"),(long)[date year]];
    } else if([date month] >0) {
        //NSLog(@"%@",[NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]]);
        return   [NSString stringWithFormat:(@"%ld天前"),(long)[date month]];
        
    } else if([date day]>0){
        //NSLog(@"%@",[NSString stringWithFormat:(@"%ld天"),(long)[date day]]); } else { NSLog(@"0天");
        return   [NSString stringWithFormat:(@"%ld天前"),(long)[date day]];
    }else if ([date hour]>0){
        return [NSString stringWithFormat:@"%ld小时前",(long)[date hour]];
    }else if ([date minute]>0){
        return [NSString stringWithFormat:@"%ld分钟前", (long)[date minute]];
    }else{
        return @"刚刚";
    }
}

- (IBAction)followClick:(id)sender {
    
    [self.delegate performSelector:@selector(addFollow:) withObject:self];
    
}
- (IBAction)goodClick:(id)sender {
    
    self.goodBtn.selected ^= 1;
    [self.delegate performSelector:@selector(addGood:) withObject:self];
    
}

- (IBAction)commentClick:(id)sender {
    
    [self.delegate performSelector:@selector(addComment:) withObject:self];
}

- (IBAction)shareClick:(id)sender {
    
    [self.delegate performSelector:@selector(addShare:) withObject:self];
    
}
@end
