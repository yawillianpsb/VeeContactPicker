//
//  Created by Andrea Cipriani on 16/03/16.
//  Copyright © 2016 Code Atlas SRL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VeeContactPickerViewController.h"
#import "VeeContactPickerStrings.h"
#import "VeeContactColors.h"
#import "VeeContactPickerOptions.h"
#import "VeeABDelegate.h"

@interface VeeContactPickerViewControllerTests : XCTestCase

@property (nonatomic, strong) VeeContactPickerViewController* veeContactPickerVCWithDefaultOptions;
@property (nonatomic, strong) VeeContactPickerViewController* veeContactPickerVCWithNilOptions;
@property (nonatomic, strong) VeeContactPickerViewController* veeContactPickerVCWithNilVeeContacts;
@property (nonatomic, strong) VeeContactPickerViewController* veeContactPickerVCWithCustomVeeContacts;
@property (nonatomic, strong) VeeContactPickerViewController* veeContactPickerVCWithCustomVeeContactsAndCustomOptions;

@property (nonatomic, strong) VeeContactPickerOptions* veeContactPickerDefaultOptions;

@end

@implementation VeeContactPickerViewControllerTests

- (void)setUp
{
    [super setUp];
    _veeContactPickerVCWithDefaultOptions = [self veeContactPickerWithDefaultConfAndViewLoaded];
    _veeContactPickerVCWithNilOptions = [[VeeContactPickerViewController alloc] initWithOptions:nil];
    _veeContactPickerVCWithNilVeeContacts = [[VeeContactPickerViewController alloc] initWithVeeContacts:nil];
    _veeContactPickerVCWithCustomVeeContacts = [[VeeContactPickerViewController alloc] initWithVeeContacts:nil]; //TODO:
    _veeContactPickerVCWithCustomVeeContactsAndCustomOptions = [[VeeContactPickerViewController alloc] initWithOptions:nil andVeeContacts:nil]; //TODO:
    
    _veeContactPickerDefaultOptions = [VeeContactPickerOptions defaultOptions];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Init

-(void)testInitWithDefaultConfigurationShouldUseDefaultOptions
{
    BOOL optionsAreDefault = [[_veeContactPickerVCWithDefaultOptions valueForKey:@"veeContactPickerOptions"] isEqual:_veeContactPickerDefaultOptions];
    NSAssert(optionsAreDefault, @"VeeContactPickerOptions are not default one");
}

-(void)testInitWithNilOptionsShouldUseDefaults
{
    BOOL pickerOptionsAreDefault = [[_veeContactPickerVCWithNilOptions valueForKey:@"veeContactPickerOptions"] isEqual:_veeContactPickerDefaultOptions];
    NSAssert(pickerOptionsAreDefault, @"VeeContactPickerOptions are not default one");
}

-(void)testInitShouldSetVeeAddressBook
{
    BOOL isVeeABSetForInitWithDefaultConfiguration = [_veeContactPickerVCWithDefaultOptions valueForKey:@"veeAddressBook"];
    BOOL isVeeABBookSetForInitWithNilOptions = [_veeContactPickerVCWithNilOptions valueForKey:@"veeAddressBook"];
    BOOL isVeeABBookSetForInitWithVeeNilContacts = [_veeContactPickerVCWithNilVeeContacts valueForKey:@"veeAddressBook"];
    BOOL isVeeABBookSetForInitWithCustomVeeContacts = [_veeContactPickerVCWithCustomVeeContacts valueForKey:@"veeAddressBook"];
    BOOL isVeeABBookSetForInitWithCustomVeeContactsAndOptions = [_veeContactPickerVCWithCustomVeeContactsAndCustomOptions valueForKey:@"veeAddressBook"];

    NSAssert(isVeeABSetForInitWithDefaultConfiguration, @"VeeAddressBook should be set in init with default configuration");
    NSAssert(isVeeABBookSetForInitWithNilOptions, @"VeeAddressBook should be set in init with nil options");
    NSAssert(isVeeABBookSetForInitWithVeeNilContacts, @"VeeAddressBook should be set in init with nil veecontacts");
    NSAssert(isVeeABBookSetForInitWithCustomVeeContacts, @"VeeAddressBook should be set in init with custom veecontacts");
    NSAssert(isVeeABBookSetForInitWithCustomVeeContactsAndOptions, @"VeeAddressBook should be set in init with custom veecontacts and custom options");
}

-(void)testInitWithNilVeecontacts
{
    BOOL veeContactsAreNil = [_veeContactPickerVCWithNilVeeContacts valueForKey:@"veeContacts"] == nil;
    NSAssert(veeContactsAreNil, @"Init with nil VeeContacts should have nil veeContactss");
}

#pragma mark - Outlets

-(void)testContactsTableViewOutletShouldBeConnected
{
    NSAssert(_veeContactPickerVCWithDefaultOptions.contactsTableView, @"TableView outlet is not connected");
}

-(void)testCancelBarButtonItemOutletShouldBeConnected
{
    NSAssert(_veeContactPickerVCWithDefaultOptions.cancelBarButtonItem, @"CancelBarButtonItem outlet is not connected");
}

-(void)testTitleNavigationItemOutletShouldBeConnected
{
    NSAssert(_veeContactPickerVCWithDefaultOptions.titleNavigationItem, @"TitleNavigationItem outlet is not connected");
}

#pragma mark - Actions

-(void)testCancelBarButtonItemPressedAction
{
    BOOL isActionCorrect = [_veeContactPickerVCWithDefaultOptions.cancelBarButtonItem action] == @selector(cancelBarButtonItemPressed:);
    NSAssert(isActionCorrect, @"CancelBarButtonItem action is not cancelBarButtonItemPressed:");
}

#pragma mark - Strings

-(void)testTitleNavigationItemTitleShouldBeInitialized
{
    BOOL isTitleCorrect = [_veeContactPickerVCWithDefaultOptions.titleNavigationItem.title isEqualToString:_veeContactPickerDefaultOptions.veeContactPickerStrings.navigationBarTitle];
    NSAssert(isTitleCorrect, @"TitleNavigationItem title is %@ but should be %@",_veeContactPickerVCWithDefaultOptions.titleNavigationItem.title,_veeContactPickerDefaultOptions.veeContactPickerStrings.navigationBarTitle);
}

-(void)testCancelBarButtomItemTitleShouldBeInitialized
{
    BOOL isTitleCorrect = [_veeContactPickerVCWithDefaultOptions.cancelBarButtonItem.title isEqualToString:_veeContactPickerDefaultOptions.veeContactPickerStrings.cancelButtonTitle];
    NSAssert(isTitleCorrect, @"CancelBarButtomItem title is %@ but should be %@",_veeContactPickerVCWithDefaultOptions.cancelBarButtonItem.title,_veeContactPickerDefaultOptions.veeContactPickerStrings.cancelButtonTitle);
}

#pragma mark - Delegates

-(void)testConformsToVeeABDelegate
{
    BOOL conformsToVeeABDelegate = [VeeContactPickerViewController conformsToProtocol:@protocol(VeeABDelegate)];
    NSAssert(conformsToVeeABDelegate, @"Picker should conforms to VeeABDelegate protocol ");
}

#pragma mark - Private utils

-(VeeContactPickerViewController*)veeContactPickerWithDefaultConfAndViewLoaded
{
    VeeContactPickerViewController *veeContactPickerVC = [[VeeContactPickerViewController alloc] initWithDefaultConfiguration];
    [veeContactPickerVC view];
    return veeContactPickerVC;
}

//testContactsAreLoadedFromABIfNil
//testABPermissions?
//testEmptyView
//testContactsAreShown
//testSearch
//testPicking

/*
 -(void)testVeecontactsSectionIdentifier
 {
 for (VeeContact* veeContact in _veecontactsForTesting) {
 NSString* veeContactSectionIdentifier = [veeContact sectionIdentifier];
 NSAssert(veeContactSectionIdentifier, @"VeeContact %@ has no section identifier",veeContact.displayName);
 BOOL isSectionIdentiferOneCharacter = [veeContactSectionIdentifier length] == 1;
 NSAssert(isSectionIdentiferOneCharacter, @"VeeContact %@ has a section identifier with length != 1: %@",veeContact.displayName,veeContactSectionIdentifier);
 }
 }
 
 -(void)testVeecontactCompleteSectionIdentifier
 {
 BOOL isSectionIdentifierCorrect = [_veeContactComplete.sectionIdentifier isEqualToString:kCompleteVeeContactSectionIdentifier];
 NSAssert(isSectionIdentifierCorrect, @"VeeContact complete sectionIdentifier is %@ but should be %@",_veeContactComplete.sectionIdentifier,kCompleteVeeContactSectionIdentifier);
 
 }
 
 -(void)testVeecontactCompleteSectionIdentifierWithoutFirstName
 {
 BOOL isSectionIdentifierCorrect = [_veeContactComplete.sectionIdentifier isEqualToString:kCompleteVeeContactWithoutFirstNameSectionIdentifier];
 [self nullifyIvarWithName:@"firstName" ofObject:_veeContactComplete];
 NSAssert(isSectionIdentifierCorrect, @"VeeContact complete sectionIdentifier is %@ but should be %@",_veeContactComplete.sectionIdentifier,kCompleteVeeContactWithoutFirstNameSectionIdentifier);
 }
 
 -(void)testVeecontactCompleteSectionIdentifierWithoutFirstNameAndLastName
 {
 BOOL isSectionIdentifierCorrect = [_veeContactComplete.sectionIdentifier isEqualToString:kCompleteVeeContactWithoutFirstNameAndLastNameSectionIdentifier];
 [self nullifyIvarWithName:@"firstName" ofObject:_veeContactComplete];
 [self nullifyIvarWithName:@"lastName" ofObject:_veeContactComplete];
 NSAssert(isSectionIdentifierCorrect, @"VeeContact complete sectionIdentifier is %@ but should be %@",_veeContactComplete.sectionIdentifier,kCompleteVeeContactWithoutFirstNameAndLastNameSectionIdentifier);
 }
 
 -(void)testVeecontactCompleteSectionIdentifierEmptyDisplayName
 {
 BOOL isSectionIdentifierCorrect = [_veeContactComplete.sectionIdentifier isEqualToString:kCompleteVeeContactEmptyDisplayNameSectionIdentifier];
 [self nullifyIvarWithName:@"firstName" ofObject:_veeContactComplete];
 [self nullifyIvarWithName:@"lastName" ofObject:_veeContactComplete];
 [self nullifyIvarWithName:@"middleName" ofObject:_veeContactComplete];
 [self nullifyIvarWithName:@"nickname" ofObject:_veeContactComplete];
 [self nullifyIvarWithName:@"organizationName" ofObject:_veeContactComplete];
 [self nullifyIvarWithName:@"emailsMutable" ofObject:_veeContactComplete];
 
 NSString* aspectedSectionIdentifier = _veeContactComplete.sectionIdentifier;
 
 NSAssert(isSectionIdentifierCorrect, @"VeeContact complete sectionIdentifier is %@ but should be %@",_veeContactComplete.sectionIdentifier,kCompleteVeeContactEmptyDisplayNameSectionIdentifier);
 }
 */

@end
