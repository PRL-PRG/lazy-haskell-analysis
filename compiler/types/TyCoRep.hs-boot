module TyCoRep where

import Data.Data  ( Data )
import GHC.Show ( Show )
import {-# SOURCE #-} Var( Var, ArgFlag, AnonArgFlag )

data Type
data TyThing
data Coercion
data UnivCoProvenance
data TyLit
data TyCoBinder
data MCoercion

type PredType = Type
type Kind = Type
type ThetaType = [PredType]
type CoercionN = Coercion
type MCoercionN = MCoercion

mkFunTy   :: AnonArgFlag -> Type -> Type -> Type
mkForAllTy :: Var -> ArgFlag -> Type -> Type

instance Data Type  -- To support Data instances in CoAxiom
instance Show Type
