# SuiAMM
Sui AMM energy trading

# EnergyToken
1. Publish token
```
sui client publish --gas-budget 100000000 .
```
2. Mint token
```
sui client call \
--function mint \
--module energytoken \
--package 0x7011f0e588f662863fa6d6894a0b1c2e3d9cc702f81b9beeed2fd750f161bd11 \
--args 0x73b2124aa416c540d79285593b0198e827e8a93e1a5f38c27877c027e205eef3 100 0xcdbfee2ea7a4c6f73203a7e11edb0f5f1b00cf6650d91877fcd00af12f83c170 \
--gas-budget 100000000
```

`Function mint:`
Create a coin worth value and increase the total supply in cap accordingly.

`public fun mint<T>(cap: &mut coin::TreasuryCap<T>, value: u64, ctx: &mut tx_context::TxContext): coin::Coin<T>`