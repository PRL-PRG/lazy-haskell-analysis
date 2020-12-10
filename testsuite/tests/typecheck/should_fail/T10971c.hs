{-# LANGUAGE MonomorphismRestriction, ExtendedDefaultRules #-}
module T10971c where

import Data.Traversable (fmapDefault)

f = \x -> length x
g = \f x -> fmapDefault f x
h = \f x -> (fmapDefault f x, length x)
