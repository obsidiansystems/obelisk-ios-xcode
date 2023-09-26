//
//  main.m
// obelisk app
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include "Rts.h"

// From ghc/rts/RtsStartup.c
extern void (*exitFn)(int);

extern StgClosure ZCMain_main_closure;

static jmp_buf mainJmpbuf;

// setjmp returns 0 on its initial call, but we want to be able to return all
// exit codes (0 - 255) through it.  So, we offset them by this amount and then
// subtract it off later.
#define EXIT_CODE_OFFSET 0x10000

static void mainFinished(int exitCode) {
  longjmp(mainJmpbuf, exitCode + EXIT_CODE_OFFSET);
}

int main(int _argc, char * _argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
    NSLog(@"hs_main");
    
    // Override Haskell's exit behavior so that it returns here instead of exiting
    // the program when 'main' finishes
    exitFn = mainFinished;
    int exitCode;
    if((exitCode = setjmp(mainJmpbuf))) {
      return exitCode - EXIT_CODE_OFFSET;
    }
    
    static int argc = 5;
    static char *argv[] = {"HaskellActivity", "+RTS", "-N", "-I0", "-RTS"};
    
    RtsConfig rts_opts = defaultRtsConfig;
    rts_opts.rts_opts_enabled = RtsOptsAll;

    hs_main(argc, argv, &ZCMain_main_closure, rts_opts);
     
    return 0; // Should never hit this
}
