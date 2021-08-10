# fennel-macro-g

How to disable this warning, while keeping all other normal functionality?

> WARNING: Attempting to use global os in compile scope.
> In future versions of Fennel this will not be allowed without the
> --no-compiler-sandbox flag or passing a :compilerEnv globals table
> in the options.

I want the macro in macro.fnl to access `os.date` or `_G.os.date`, but can't
find a configuration that doesn't warn.

```
lua demo.lua 
```
