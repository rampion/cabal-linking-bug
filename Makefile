demo: clean
	cabal sandbox init
	cd Dependency && cp ../cabal.sandbox.config . && cabal install
	cd Minimal && cp ../cabal.sandbox.config . && cabal build

clean:
	cd Minimal && cabal clean && rm -f cabal.sandbox.config
	cd Dependency && cabal clean && rm -f cabal.sandbox.config
	if [ -f cabal.sandbox.config ] ; then cabal sandbox delete ; fi
