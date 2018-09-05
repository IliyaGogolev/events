//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <contacts_service/ContactsServicePlugin.h>
#import <firebase_auth/FirebaseAuthPlugin.h>
#import <google_sign_in/GoogleSignInPlugin.h>
#import <simple_permissions/SimplePermissionsPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [ContactsServicePlugin registerWithRegistrar:[registry registrarForPlugin:@"ContactsServicePlugin"]];
  [FLTFirebaseAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAuthPlugin"]];
  [FLTGoogleSignInPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleSignInPlugin"]];
  [SimplePermissionsPlugin registerWithRegistrar:[registry registrarForPlugin:@"SimplePermissionsPlugin"]];
}

@end
