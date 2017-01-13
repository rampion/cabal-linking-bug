module Dependency where
import Dependency.External
import Dependency.Internal
dependencyId :: a -> a
dependencyId = let () = externalUnit in internalId
