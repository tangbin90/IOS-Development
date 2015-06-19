//
//  BIDNameAndColorCell.m
//  TableView
//
//  Created by tangbin on 6/1/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "BIDNameAndColorCell.h"
@interface BIDNameAndColorCell()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;
@end
@implementation BIDNameAndColorCell
/*-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
        UILabel *nameMarker=[[UILabel alloc]initWithFrame:nameLabelRect];
        nameMarker.textAlignment=NSTextAlignmentRight;
        nameMarker.font=[UIFont boldSystemFontOfSize:12];
        nameMarker.text=@"Name:";
        [self.contentView addSubview:nameMarker];
        
        CGRect colorLabelRect=CGRectMake(0, 26, 70, 15);
        UILabel *colorMaker=[[UILabel alloc]initWithFrame:colorLabelRect];
        colorMaker.textAlignment=NSTextAlignmentRight;
        colorMaker.text=@"Color";
        colorMaker.font=[UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorMaker];
        
        CGRect nameValuerect=CGRectMake(80, 5, 200, 15);
        _nameLabel=[[UILabel alloc]initWithFrame:nameValuerect];
        [self.contentView addSubview:_nameLabel];
        
        CGRect colorValueRect=CGRectMake(80, 25, 200, 15);
        _colorLabel=[[UILabel alloc]initWithFrame:colorValueRect];
        
        [self.contentView addSubview:_colorLabel];
    }
    return self;
}*/

-(void)setName:(NSString *)name
{
    if(![name isEqualToString:_name])
    {
        _name=[name copy];
        self.nameLabel.text=_name;
    }
}

-(void)setColor:(NSString *)color
{
    if(![color isEqualToString:_color])
    {
        _color=[color copy];
        self.colorLabel.text=_color;
    }
}
@end
