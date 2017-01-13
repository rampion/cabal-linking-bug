This is a mimimal demo to recreate a "can't load .so/.DLL" error when running
`cabal build`.

The necessary factors seem to be that the package being built:
- contain a module that uses `TemplateHaskell`
- have a dependency on a package that contains a module that imports
  values from exposed modules in that package and hidden modules in that
  package.

To see the bug, run `make demo`. 

```
$ make demo
cd Minimal && cabal clean && rm -f cabal.sandbox.config
cleaning...
cd Dependency && cabal clean && rm -f cabal.sandbox.config
cleaning...
if [ -f cabal.sandbox.config ] ; then cabal sandbox delete ; fi
Deleting the sandbox located at
$CWD/.cabal-sandbox
cabal sandbox init
Writing a default package environment file to
$CWD/cabal.sandbox.config
Creating a new sandbox at
$CWD/.cabal-sandbox
cd Dependency && cp ../cabal.sandbox.config . && cabal install
Resolving dependencies...
Notice: installing into a sandbox located at
$CWD/.cabal-sandbox
Configuring Dependency-0.1.0.0...
Building Dependency-0.1.0.0...
Installed Dependency-0.1.0.0
cd Minimal && cp ../cabal.sandbox.config . && cabal build
Package has never been configured. Configuring with default flags. If this
fails, please run configure manually.
Resolving dependencies...
Configuring Minimal-0.1.0.0...
Building Minimal-0.1.0.0...
Preprocessing library Minimal-0.1.0.0...
[1 of 1] Compiling Minimal          ( Minimal.hs, dist/build/Minimal.o )

<no location info>:
    <command line>: can't load .so/.DLL for: $CWD/.cabal-sandbox/lib/x86_64-osx-ghc-7.10.2/Dependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL/libHSDependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL-ghc7.10.2.dylib (dlopen($CWD/.cabal-sandbox/lib/x86_64-osx-ghc-7.10.2/Dependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL/libHSDependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL-ghc7.10.2.dylib, 5): Symbol not found: _Depenzu3bQUv6TYJi0E1RrRDfYHiL_DependencyziInternal_internalId_info
  Referenced from: $CWD/.cabal-sandbox/lib/x86_64-osx-ghc-7.10.2/Dependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL/libHSDependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL-ghc7.10.2.dylib
  Expected in: flat namespace
 in $CWD/.cabal-sandbox/lib/x86_64-osx-ghc-7.10.2/Dependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL/libHSDependency-0.1.0.0-3bQUv6TYJi0E1RrRDfYHiL-ghc7.10.2.dylib)
make: *** [demo] Error 1
```

This behaviour has been observed on OSX with `cabal-install-1.22.6.0/Cabal-1.22.4.0/ghc-7.10.2`, `cabal-install-1.22.6.0/Cabal-1.22.6.0/ghc-7.10.3`, and
on Centos6 with `cabal-install-1.24.0.1/Cabal-1.24.1.0/ghc-8.0.1`.
