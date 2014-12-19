@import Foundation;


@interface KASOptional : NSObject
/**
 Returns stored value. Before it attempts to assert that there is stored value. If there is no value it may throw exception
 */
@property (nonatomic, readonly) id value;
/**
 Returns stored pointer. Before it attempts to assert that there is stored pointer. If there is no pointer it may throw exception
 */
@property (nonatomic, readonly) const void *pointer;
@property (nonatomic, readonly) BOOL hasValue;
@property (nonatomic, readonly) BOOL hasPointer;

// MARK: Initialization

+ (instancetype)instanceWithValue:(const id)value;
+ (instancetype)instanceWithPointerToCObject:(const void* const)pointer;
- (instancetype)initWithValue:(const id)value;
- (instancetype)initWithPointerToCObject:(const void* const)pointer;
/**
 Instance without value or pointer
 @return instance
 */
- (instancetype)init;

// MARK: Customization

/**
 YES: Assertations are enabled
 NO: Assertations are disabled
 Default: YES
 */
+ (void)setAreAssertationsInDebugEnabled:(const BOOL)value;
/**
 YES: Exceptions will be thrown
 NO: Exceptions will not be thrown
 Default: YES
 */
+ (void)setAreExceptionsInReleaseEnabled:(const BOOL)value;

@end
