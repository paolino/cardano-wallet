{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

-- |
-- Copyright: © 2022 IOHK
-- License: Apache-2.0
--
-- This module provides the 'SelectionContext' class, which provides a shared
-- context for types used by coin selection.
--
module Cardano.Wallet.CoinSelection.Internal.Context
    (
    -- * Selection contexts
      SelectionContext (..)
    )
    where

import Prelude

import Cardano.Wallet.Primitive.Types.TokenBundle
    ( TokenBundle )
import Data.Set
    ( Set )
import Fmt
    ( Buildable )

-- | Provides a shared context for types used by coin selection.
--
class
    ( Buildable (Address c)
    , Buildable (UTxO c)
    , Ord (Address c)
    , Ord (UTxO c)
    , Show (Address c)
    , Show (UTxO c)
    ) =>
    SelectionContext c
  where

    -- | A target address to which payments can be made.
    type Address c

    -- | A unique identifier for an asset.
    type Asset c

    -- | A unique identifier for an individual UTxO.
    type UTxO c

    -- | Generates a dummy address value.
    dummyAddress :: Address c

    -- | Returns the set of assets held in a token bundle.
    tokenBundleAssets :: TokenBundle -> Set (Asset c)

    -- | Returns a count of the number of assets held in a token bundle.
    tokenBundleAssetCount :: TokenBundle -> Int

    -- | Indicates whether the given token bundle has the given asset.
    tokenBundleHasAsset :: TokenBundle -> Asset c -> Bool
