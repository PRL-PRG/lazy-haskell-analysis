module TcType where
import Outputable( SDoc )
import GHC.Show ( Show )

data MetaDetails

data TcTyVarDetails
pprTcTyVarDetails :: TcTyVarDetails -> SDoc
vanillaSkolemTv :: TcTyVarDetails
instance Show TcTyVarDetails
