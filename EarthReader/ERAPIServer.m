//
//  ERAPIServer.m
//  EarthReader
//
//  Created by 김태호 on 2014. 1. 1..
//  Copyright (c) 2014년 Earth Reader. All rights reserved.
//

#import "ERAPIServer.h"
#include "python2.7/Python.h"

NSString * const ERAPIServerUserDefaultsSessionIDKey = @"session-id";

static PyObject *ERAPIServerCreate(NSString *repoPath, NSString *sessionID) {
    PyObject *server = NULL;
    PyObject *helpers = PyImport_ImportModule("helpers");
    
    if (helpers) {
        server = PyObject_CallMethod(helpers, "new_server", "(ss)", repoPath.UTF8String, sessionID.UTF8String);
        Py_XDECREF(helpers);
    }
    
    if (PyErr_Occurred()) {
        PyErr_Print();
    }
    return server;
}

static NSUInteger ERAPIServerGetPort(PyObject *server) {
    PyObject *attr = PyObject_GetAttrString(server, "effective_port");
    NSUInteger port = PyInt_AsLong(attr);
    Py_XDECREF(attr);
    return port;
}

static void ERAPIServerRun(PyObject *server) {
    PyObject_CallMethod(server, "run", NULL);
}

@interface ERAPIServer () {
    PyObject *_server;
    dispatch_queue_t _queue;
}
@end

@implementation ERAPIServer

+ (ERAPIServer *)sharedServer {
    static ERAPIServer *server = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        server = [[self alloc] init];
    });
    return server;
}

+ (NSString *)defaultSessionID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [defaults stringForKey:ERAPIServerUserDefaultsSessionIDKey];
    if (!sessionId) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        if (uuid) {
            sessionId = (__bridge NSString *)CFUUIDCreateString(NULL, uuid);
            CFRelease(uuid);
        }
        [defaults setObject:sessionId forKey:ERAPIServerUserDefaultsSessionIDKey];
        [defaults synchronize];
    }
    return sessionId;
}

- (id)init {
    if (self = [super init]) {
        _repositoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        _queue = dispatch_queue_create("earthreader-web", NULL);
    }
    return self;
}

- (void)start {
    _server = ERAPIServerCreate(_repositoryPath, [ERAPIServer defaultSessionID]);
    _port = ERAPIServerGetPort(_server);
    dispatch_async(_queue, ^{
        ERAPIServerRun(_server);
    });
}

- (void)stop {
    PyObject *server = _server;
    _server = NULL;
    _port = 0;
    
    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();
    PyErr_SetString(PyExc_KeyboardInterrupt, "Stop it!");
    PyGILState_Release(gstate);
    
    // Wait for stop
    dispatch_sync(_queue, ^{
        PyObject_CallMethod(server, "close", NULL);
        Py_XDECREF(server);
    });
}

- (void)dealloc {
    [self stop];
}

@end
