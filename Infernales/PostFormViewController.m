//
//  PostFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 21.03.13.
//
//

#import "PostFormViewController.h"

#define kChatBarHeight1                      40
#define kChatBarHeight4                      94
#define TEXT_VIEW_X                          7   // 40  (with CameraButton)
#define TEXT_VIEW_Y                          2
#define TEXT_VIEW_WIDTH                      249 // 216 (with CameraButton)
#define TEXT_VIEW_HEIGHT_MIN                 90
#define MessageFontSize                      16


#define UIKeyboardNotificationsObserve() \
NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter]; \
[notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil]


@interface PostFormViewController () <UITextViewDelegate> {
    CGFloat _previousTextViewContentHeight;
}

@end

@implementation PostFormViewController

@synthesize forumId, threadId, formText, formString, editMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressConfirmButton:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    formText.text = formString;

 
    
    // Create messageInputBar to contain _textView, messageInputBarBackgroundImageView, & _sendButton.
    UIImageView *messageInputBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-kChatBarHeight1, self.view.frame.size.width, kChatBarHeight1)];
    messageInputBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    messageInputBar.opaque = YES;
    messageInputBar.userInteractionEnabled = YES; // makes subviews tappable
    messageInputBar.image = [[UIImage imageNamed:@"MessageInputBarBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(19, 3, 19, 3)]; // 8 x 40
    
    // Create _textView to compose messages.
    // TODO: Shrink cursor height by 1 px on top & 1 px on bottom.
    _textView = [[ACPlaceholderTextView alloc] initWithFrame:CGRectMake(TEXT_VIEW_X, TEXT_VIEW_Y, TEXT_VIEW_WIDTH, TEXT_VIEW_HEIGHT_MIN)];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor colorWithWhite:245/255.0f alpha:1];
    _textView.scrollIndicatorInsets = UIEdgeInsetsMake(13, 0, 8, 6);
    _textView.scrollsToTop = NO;
    _textView.font = [UIFont systemFontOfSize:MessageFontSize];
    _textView.placeholder = NSLocalizedString(@" Message", nil);
    _textView.autocorrectionType = UITextAutocorrectionTypeNo;
    [messageInputBar addSubview:_textView];
    _previousTextViewContentHeight = MessageFontSize+20;

    
//    [_textView release];
    
    // Create messageInputBarBackgroundImageView as subview of messageInputBar.
    UIImageView *messageInputBarBackgroundImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"MessageInputFieldBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 12, 18, 18)]]; // 32 x 40
    messageInputBarBackgroundImageView.frame = CGRectMake(TEXT_VIEW_X-2, 0, TEXT_VIEW_WIDTH+2, kChatBarHeight1);
    messageInputBarBackgroundImageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [messageInputBar addSubview:messageInputBarBackgroundImageView];
    
    
    [messageInputBarBackgroundImageView release];
    
    // Create sendButton.
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(messageInputBar.frame.size.width-65, 8, 59, 26);
    _sendButton.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin /* multiline input */ | UIViewAutoresizingFlexibleLeftMargin /* landscape */);
    UIEdgeInsets sendButtonEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 13); // 27 x 27
    UIImage *sendButtonBackgroundImage = [[UIImage imageNamed:@"SendButton"] resizableImageWithCapInsets:sendButtonEdgeInsets];
    [_sendButton setBackgroundImage:sendButtonBackgroundImage forState:UIControlStateNormal];
    [_sendButton setBackgroundImage:sendButtonBackgroundImage forState:UIControlStateDisabled];
    [_sendButton setBackgroundImage:[[UIImage imageNamed:@"SendButtonHighlighted"] resizableImageWithCapInsets:sendButtonEdgeInsets] forState:UIControlStateHighlighted];
    _sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _sendButton.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    [_sendButton setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
    [_sendButton setTitleShadowColor:[UIColor colorWithRed:0.325f green:0.463f blue:0.675f alpha:1] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(pressConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    [messageInputBar addSubview:_sendButton];
    
    [_sendButton release];
    
//    NSLog(@"%@",_textView);
    
    [self.view addSubview:messageInputBar];
    
    [messageInputBar release];
    
    if(editMode == TRUE) {
        _textView.text = formString;
        [self textViewDidChange:_textView];
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIKeyboardNotificationsObserve();
}


- (void)keyboardWillShow:(NSNotification *)notification {
//    NSTimeInterval animationDuration;
//    UIViewAnimationCurve animationCurve;
    CGRect frameEnd;
    NSDictionary *userInfo = [notification userInfo];
//    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
//    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frameEnd];
    
//    //    NSLog(@"animationDuration: %f", animationDuration); // TODO: Why 0.35 on viewDidLoad?
////    [UIView animateWithDuration:animationDuration delay:0.0 options:(UIViewAnimationOptionsFromCurve(animationCurve) | UIViewAnimationOptionBeginFromCurrentState) animations:^{
////        UIViewSetFrameY(messageInputBar, viewHeight-messageInputBar.frame.size.height);
//////        _tableView.contentInset = _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.view.frame.size.height-viewHeight, 0);
////        [self scrollToBottomAnimated:NO];
////    } completion:nil];
//    CGFloat viewHeight = [self.view convertRect:frameEnd fromView:nil].origin.y;
//    UIView *messageInputBar = _textView.superview;
    
    UIView *messageInputBar = _textView.superview;
//    CGRect frameEnd;
    CGFloat viewHeight = [self.view convertRect:frameEnd fromView:nil].origin.y;
    messageInputBar.frame = CGRectMake(messageInputBar.frame.origin.x, viewHeight-messageInputBar.frame.size.height, messageInputBar.frame.size.width, messageInputBar.frame.size.height);
    
    
    
}



-(void)pressConfirmButton {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];

    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.infernales.de/portal/forum/postreply.json.php?forum_id=%@&thread_id=%@&username=%@&password=%@",forumId, threadId, username, password]];
//    NSLog(@"URL: %@", [url description]);
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSString *message = _textView.text;
    [request setPostValue:message forKey:@"message"];
    [request setPostValue:@"1" forKey:@"postreply"];
    
    request.delegate = self;
    [request startAsynchronous];
//    NSError *error = [request error];
//    if (!error) {
//        NSString *respone_message = [request responseString];
//    } else {
//        
//    }

    
//    NSString *respone_message = [request responseString];
    
//    NSLog(@"Status Message: %@", status_message);
    

    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
//    NSLog(@"Response: %@", request);
    
    NSDictionary *response = [responseString JSONValue];
//    NSDictionary *response = nil;
//    NSLog(@"Response Dict: %@", response);
//    NSLog(@"Response String: %@", responseString);
    if ([[response objectForKey:@"code"] compare:[NSNumber numberWithInt:0]] == NSOrderedSame) {
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        del.needsUpdatePost = true;
        NSUInteger *index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[PostViewController class]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // Use when fetching binary data
//    NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}




#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    // Change height of _tableView & messageInputBar to match textView's content height.
    CGFloat textViewContentHeight = textView.contentSize.height;
    CGFloat changeInHeight = textViewContentHeight - _previousTextViewContentHeight;
    //    NSLog(@"textViewContentHeight: %f", textViewContentHeight);
    
    if (textViewContentHeight+changeInHeight > kChatBarHeight4+2) {
        changeInHeight = kChatBarHeight4+2-_previousTextViewContentHeight;
    }
    
    if (changeInHeight) {
        [UIView animateWithDuration:0.2 animations:^{
            UIView *messageInputBar = _textView.superview;
            messageInputBar.frame = CGRectMake(0, messageInputBar.frame.origin.y-changeInHeight, messageInputBar.frame.size.width, messageInputBar.frame.size.height+changeInHeight);
        } completion:^(BOOL finished) {
            [_textView updateShouldDrawPlaceholder];
        }];
        _previousTextViewContentHeight = MIN(textViewContentHeight, kChatBarHeight4+2);
    }
    
    // Enable/disable sendButton if textView.text has/lacks length.
    if ([textView.text length]) {
        _sendButton.enabled = YES;
        _sendButton.titleLabel.alpha = 1;
    } else {
        _sendButton.enabled = NO;
        _sendButton.titleLabel.alpha = 0.5f; // Sam S. says 0.4f
    }
}
@end
