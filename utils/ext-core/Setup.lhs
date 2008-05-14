#!/usr/bin/env runhaskell
\begin{code}
{-# OPTIONS -Wall #-}

import Control.Monad
import Data.List
import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.Utils
import System.Cmd
import System.FilePath
import System.Exit
import System.Directory
import Control.Exception (try)

main :: IO ()
main = do
   let hooks = defaultUserHooks {
                 buildHook = build_primitive_sources 
                           $ buildHook defaultUserHooks
            }
   defaultMainWithHooks hooks
\end{code}

Mostly snarfed from ghc-prim's Setup.hs.

\begin{code}
type Hook a = PackageDescription -> LocalBuildInfo -> UserHooks -> a -> IO ()

build_primitive_sources :: Hook a -> Hook a
build_primitive_sources f pd lbi uhs x
 = do when (compilerFlavor (compiler lbi) == GHC) $ do
          let genprimopcode = joinPath ["..", "..", "utils",
                                        "genprimopcode", "genprimopcode"]
              primops = joinPath ["..", "..", "compiler", "prelude",
                                  "primops.txt"]
              primhs = joinPath ["Language", "Core", "PrimEnv.hs"]
              primhs_tmp = addExtension primhs "tmp"
          maybeExit $ system (genprimopcode ++ " --make-ext-core-source < "
                           ++ primops ++ " > " ++ primhs_tmp)
          maybeUpdateFile primhs_tmp primhs
          maybeExit $ system ("make -C lib/GHC_ExtCore")
      f pd lbi uhs x

-- Replace a file only if the new version is different from the old.
-- This prevents make from doing unnecessary work after we run 'setup makefile'
maybeUpdateFile :: FilePath -> FilePath -> IO ()
maybeUpdateFile source target = do
  r <- rawSystem "cmp" ["-s" {-quiet-}, source, target]
  case r of
    ExitSuccess   -> removeFile source
    ExitFailure _ -> do try (removeFile target); renameFile source target


\end{code}