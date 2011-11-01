//
//  NotificationView.h
//  iBroke
//
//  Created by Mujtaba Hussain on 1/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationView : UIView

typedef enum
{
  kErrorNotification = 0,
  kSuccessNotification,
}
NotificationType;

- (id)initWithFrame:(CGRect)frame andMessage:(NSString *)message andType:(NotificationType)type;

@end
