module IdInfo where
import GhcPrelude
import Outputable
data IdInfo
instance Show IdInfo
data IdDetails
instance Show IdDetails

vanillaIdInfo :: IdInfo
coVarDetails :: IdDetails
isCoVarDetails :: IdDetails -> Bool
pprIdDetails :: IdDetails -> SDoc

