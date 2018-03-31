{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_haskell_contracts (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/cameron/.cabal/bin"
libdir     = "/home/cameron/.cabal/lib/x86_64-linux-ghc-8.0.2/haskell-contracts-0.1.0.0-LkFuMxqIv1w5UN7nhUfxuz"
dynlibdir  = "/home/cameron/.cabal/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/home/cameron/.cabal/share/x86_64-linux-ghc-8.0.2/haskell-contracts-0.1.0.0"
libexecdir = "/home/cameron/.cabal/libexec"
sysconfdir = "/home/cameron/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haskell_contracts_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haskell_contracts_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "haskell_contracts_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "haskell_contracts_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_contracts_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_contracts_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
