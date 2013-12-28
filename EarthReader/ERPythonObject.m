//
//  ERPythonObject.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"

@implementation ERPythonObject

+ (ERPythonObject *)moduleWithName:(const char *)name {
    PyObject *mod = PyImport_ImportModule(name);
    ERPythonObject *wrapped = [[ERPythonObject alloc] initWithHandle:mod];
    Py_XDECREF(mod);
    return wrapped;
}

+ (ERPythonObject *)classWithName:(const char *)name
                       fromModule:(const char *)mod {
    PyObject *modobj = PyImport_ImportModule(mod);
    PyObject *clsobj = PyObject_GetAttrString(modobj, name);
    ERPythonObject *wrapped = [[ERPythonObject alloc] initWithHandle:clsobj];
    Py_XDECREF(clsobj);
    Py_XDECREF(modobj);
    return wrapped;
}

- (id)initWithHandle:(PyObject *)handle {
    if (self = [super init]) {
        _handle = handle;
        Py_XINCREF(_handle);
    }
    return self;
}

- (id)initWithWrappedObject:(ERPythonObject *)obj {
    return [self initWithHandle:obj.handle];
}

- (ERPythonObject *)callWithArgs:(const char *)spec, ... {
    va_list va;
    va_start(va, spec);
    PyObject *args = Py_VaBuildValue(spec, va);
    va_end(va);
    
    PyObject *ret = PyObject_Call(_handle, args, NULL);
    ERPythonObject *wrapped = [[ERPythonObject alloc] initWithHandle:ret];
    Py_XDECREF(ret);
    Py_XDECREF(args);
    return wrapped;
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    NSString *keyString = (NSString *)key; // XXX
    PyObject *attr = PyObject_GetAttrString(_handle, [keyString UTF8String]);
    ERPythonObject *wrapped = [[ERPythonObject alloc] initWithHandle:attr];
    Py_XDECREF(attr);
    return wrapped;
}

- (void)print {
    PyObject_Print(_handle, stderr, 0);
    fputc('\n', stderr);
}

- (NSString *)stringValue {
    PyObject *str = _handle;
    if (PyUnicode_Check(str)) {
        str = PyUnicode_AsUTF8String(str);
    }
    // TODO: deref str
    return [[NSString alloc] initWithCString:PyString_AsString(str) encoding:NSUTF8StringEncoding];
}

- (void)dealloc {
    Py_XDECREF(_handle);
}

@end