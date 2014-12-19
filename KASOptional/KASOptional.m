#import "KASOptional.h"


static BOOL areAssertationsOnDebugEnabled = YES;
static BOOL areExceptionsOnReleaseEnabled = YES;

#ifdef DEBUG
#define IF_NO_CONDITION_THROW_EXCEPTION_OR_RETURN_VALUE(CONDITION, MESSAGE, VALUE) \
if (!(CONDITION)) \
{ \
    if (areAssertationsOnDebugEnabled) \
    { \
        NSAssert(NO, MESSAGE); \
    } \
    else \
    { \
        return VALUE; \
    } \
}
#else
#define IF_NO_CONDITION_THROW_EXCEPTION_OR_RETURN_VALUE(CONDITION, MESSAGE, VALUE) \
if (!(CONDITION)) \
{ \
    if (areExceptionsOnReleaseEnabled) \
    { \
        @throw [NSException exceptionWithName:@"Error in optional" reason:MESSAGE userInfo:nil]; \
    } \
    else \
    { \
        return VALUE; \
    } \
}
#endif



@interface KASOptional ()
@property (nonatomic) id value;
@property (nonatomic, assign) const void *pointer;
@property (nonatomic, assign) BOOL hasValue;
@property (nonatomic, assign) BOOL hasPointer;
@end


@implementation KASOptional

// MARK: Initialization

+ (instancetype)instanceWithPointerToCObject:(const void *const)pointer
{
    return [[self alloc] initWithPointerToCObject:pointer];
}

+ (instancetype)instanceWithValue:(const id)value
{
    return [[self alloc] initWithValue:value];
}

- (instancetype)initWithPointerToCObject:(const void *const)pointer
{
    IF_NO_CONDITION_THROW_EXCEPTION_OR_RETURN_VALUE(pointer != NULL, @"Pointer is NULL", nil)

    self = [self init];
    if (self == nil)
    {
        return nil;
    }
    
    self.pointer = pointer;
    self.hasPointer = YES;
    
    return self;
}

- (instancetype)initWithValue:(const id)value
{
    IF_NO_CONDITION_THROW_EXCEPTION_OR_RETURN_VALUE(value != nil, @"Value is nil", nil)

    self = [self init];
    if (self == nil)
    {
        return nil;
    }
    
    self.value = value;
    self.hasValue = YES;
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    self.hasPointer = NO;
    self.hasValue = NO;
    
    return self;
}

// MARK: Property accessors

- (const void *)pointer
{
    IF_NO_CONDITION_THROW_EXCEPTION_OR_RETURN_VALUE(_pointer != NULL, @"There is no pointer", nil);
    return _pointer;
}

- (id)value
{
    IF_NO_CONDITION_THROW_EXCEPTION_OR_RETURN_VALUE(_value != nil, @"There is no value", nil);
    return _value;
}

// MARK: Customization

+ (void)setAreAssertationsInDebugEnabled:(const BOOL)value
{
    areAssertationsOnDebugEnabled = value;
}

+ (void)setAreExceptionsInReleaseEnabled:(const BOOL)value
{
    areExceptionsOnReleaseEnabled = value;
}

@end
