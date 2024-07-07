// Copyright (c) Sui Foundation, Inc.
// SPDX-License-Identifier: Apache-2.0

#[test_only]
module money_token::moneytoken_tests {

    use money_token::moneytoken::{Self, MONEYTOKEN};
    use sui::coin::{Coin, TreasuryCap};
    use sui::test_scenario::{Self, next_tx, ctx};

    #[test]
    fun mint_burn() {
        // Initialize a mock sender address
        let addr1 = @0xA;

        // Begins a multi transaction scenario with addr1 as the sender
        let mut scenario = test_scenario::begin(addr1);
        
        // Run the managed coin module init function
        {
            moneytoken::test_init(ctx(&mut scenario))
        };

        // Mint a `Coin<MANAGED>` object
        next_tx(&mut scenario, addr1);
        {
            let mut treasurycap = test_scenario::take_from_sender<TreasuryCap<MONEYTOKEN>>(&scenario);
            moneytoken::mint(&mut treasurycap, 100, addr1, test_scenario::ctx(&mut scenario));
            test_scenario::return_to_address<TreasuryCap<MONEYTOKEN>>(addr1, treasurycap);
        };

        // Burn a `Coin<MANAGED>` object
        next_tx(&mut scenario, addr1);
        {
            let coin = test_scenario::take_from_sender<Coin<MONEYTOKEN>>(&scenario);
            let mut treasurycap = test_scenario::take_from_sender<TreasuryCap<MONEYTOKEN>>(&scenario);
            moneytoken::burn(&mut treasurycap, coin);
            test_scenario::return_to_address<TreasuryCap<MONEYTOKEN>>(addr1, treasurycap);
        };

        // Cleans up the scenario object
        test_scenario::end(scenario);
    }

}