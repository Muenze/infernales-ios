//
//  MessageNewViewController.h
//  Infernales
//
//  Created by Guido Wehner on 28.04.13.
//
//

#import <UIKit/UIKit.h>

@interface MessageNewViewController : UIViewController <UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *svMyScrollView;
@property (retain, nonatomic) IBOutlet UITextField *txtSubject;
@property (retain, nonatomic) IBOutlet UITextView *txtMessage;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerReciever;



@end
