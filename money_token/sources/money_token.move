// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Example coin with a trusted manager responsible for minting/burning (e.g., a stablecoin)
/// By convention, modules defining custom coin types use upper case names, in contrast to
/// ordinary modules, which use camel case.
module money_token::moneytoken {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::url;

    /// Name of the coin. By convention, this type has the same name as its parent module
    /// and has no fields. The full type of the coin defined by this module will be `COIN<MANAGED>`.
    public struct MONEYTOKEN has drop {}

    /// Register the managed currency to acquire its `TreasuryCap`. Because
    /// this is a module initializer, it ensures the currency only gets
    /// registered once.
    fun init(witness: MONEYTOKEN, ctx: &mut TxContext) {
        // Get a treasury cap for the coin and give it to the transaction sender
        let url_bytes = b"https://github.com/CaixiangFan/SuiAMM/blob/main/money_token/manifacts/mtk.png";
        let (treasury_cap, metadata) = coin::create_currency<MONEYTOKEN>(
            witness,
            6,                     // decimals
            b"MTK",                // symbol
            b"Money Token",       // name
            b"Tokenized Money",   // description
            option::some(url::new_unsafe_from_bytes(url_bytes)),        // icon url
            ctx
          );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }

    /// Manager can mint new coins
    public fun mint(
        treasury_cap: &mut TreasuryCap<MONEYTOKEN>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    /// Manager can burn coins
    public fun burn(treasury_cap: &mut TreasuryCap<MONEYTOKEN>, coin: Coin<MONEYTOKEN>) {
        coin::burn(treasury_cap, coin);
    }

    #[test_only]
    /// Wrapper of module initializer for testing
    public fun test_init(ctx: &mut TxContext) {
        init(MONEYTOKEN {}, ctx)
    }
}