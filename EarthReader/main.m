//
//  main.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 27..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ERAppDelegate.h"

void load_custom_builtin_importer();

int main(int argc, char * argv[])
{
    @autoreleasepool {
        putenv("PYTHONOPTIMIZE=2");
        putenv("PYTHONDONTWRITEBYTECODE=1");
        putenv("PYTHONNOUSERSITE=1");
        putenv("PYTHONPATH=.");
        
        NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
        NSLog(@"PythonHome is: %s", (char *)[resourcePath UTF8String]);
        Py_SetPythonHome((char *)[resourcePath UTF8String]);
        
        NSLog(@"Initializing python");
        Py_Initialize();
        PySys_SetArgv(argc, argv);
        
        // If other modules are using thread, we need to initialize them before.
        PyEval_InitThreads();
        
        // Add an importer for builtin modules
        load_custom_builtin_importer();
        
        int ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([ERAppDelegate class]));
        Py_Finalize();
        NSLog(@"Leaving");
        
        exit(ret);
        return ret;
    }
}

void load_custom_builtin_importer() {
    static const char *custom_builtin_importer = \
    "import sys, imp\n" \
    "from os import environ\n" \
    "from os.path import exists, join\n" \
    "# Fake redirection when we run the app without xcode\n" \
    "if 'CFLOG_FORCE_STDERR' not in environ:\n" \
    "    class fakestd(object):\n" \
    "        def write(self, *args, **kw): pass\n" \
    "        def flush(self, *args, **kw): pass\n" \
    "    sys.stdout = fakestd()\n" \
    "    sys.stderr = fakestd()\n" \
    "# Custom builtin importer for precompiled modules\n" \
    "class CustomBuiltinImporter(object):\n" \
    "    def find_module(self, fullname, mpath=None):\n" \
    "        if '.' not in fullname:\n" \
    "            return\n" \
    "        if mpath is None:\n" \
    "            return\n" \
    "        part = fullname.rsplit('.')[-1]\n" \
    "        fn = join(mpath[0], '{}.so'.format(part))\n" \
    "        if exists(fn):\n" \
    "            return self\n" \
    "        return\n" \
    "    def load_module(self, fullname):\n" \
    "        f = fullname.replace('.', '_')\n" \
    "        mod = sys.modules.get(f)\n" \
    "        if mod is None:\n" \
    "            #print 'LOAD DYNAMIC', f\n" \
    "            try:\n" \
    "                mod = imp.load_dynamic(f, f)\n" \
    "            except ImportError:\n" \
    "                #print 'LOAD DYNAMIC FALLBACK', fullname\n" \
    "                mod = imp.load_dynamic(fullname, fullname)\n" \
    "            return mod\n" \
    "        return mod\n" \
    "sys.meta_path.append(CustomBuiltinImporter())";
    PyRun_SimpleString(custom_builtin_importer);
}