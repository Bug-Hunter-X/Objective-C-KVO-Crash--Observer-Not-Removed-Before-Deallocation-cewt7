In Objective-C, a subtle bug can occur when dealing with KVO (Key-Value Observing) and object lifecycles.  If an observer is not removed properly before the observed object is deallocated, it can lead to crashes or unexpected behavior. This is because the observer might try to access the deallocated object, resulting in a EXC_BAD_ACCESS error. For example:

```objectivec
@interface MyClass : NSObject
@property (nonatomic, strong) NSString *observedString;
@end

@implementation MyClass
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // Handle KVO notification
}

- (void)startObserving {
    [self addObserver:self forKeyPath:@"observedString" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)stopObserving {
    [self removeObserver:self forKeyPath:@"observedString"];
}
@end
```

If `stopObserving` is not called before `MyClass` is deallocated, a crash will occur. 