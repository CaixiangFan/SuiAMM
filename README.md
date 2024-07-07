# SuiAMM
Sui AMM energy trading

# Deployment
1. Select `Sui Devtnet`.
```
sui client envs
sui client switch --address 0xadaee10b2fa28751ad046e0bd30404395f3fac424f48856c19e557fa68a5f810 --env devnet
```
2. Publish token
```
sui client publish --gas-budget 100000000 .
```
Question: how to add a token icon url in the `init` function?
``https://github.com/CaixiangFan/SuiAMM/blob/main/energy_token/manifacts/etk.png``
We got the published object ID:
```
┌──
│  │ ID: 0xfd9982317ad04e543e4f41045d017ccfada0ce1c3a44a833d51e360a2236b346                                    │
│  │ Version: 11                                                                                               │
│  │ Digest: Dnm7W2MmsmcZhMTQ6VYyotDiuJgVcz5cTRUAr6NKp4bS                                                      │
│  └──    
```
3. Mint token
```
sui client call \
--function mint \
--module energytoken \
--package 0x837adaa63169334c880ccb3708668ba378b5e10f2f02e1fd3b9a39d630a14370 \
--args 0x3d25df1d63e1710e8904af216f1ce72dde2cdbf539d899e6854e6255076801e1 100000000 0xadaee10b2fa28751ad046e0bd30404395f3fac424f48856c19e557fa68a5f810 \
--gas-budget 100000000
```

```
sui client call \
--function mint \
--module moneytoken \
--package 0xaf5792eab0963e2b0856e0c75cb2f8458a494ec9c8e1174d8ea4d51af7b3fdaf \
--args 0xd70f3210e16d764226d3b080ee823498ab4354a2553b4444d36d8d6b3e940663 100000000 0xadaee10b2fa28751ad046e0bd30404395f3fac424f48856c19e557fa68a5f810 \
--gas-budget 100000000
```

`Function mint:`
Create a coin worth value and increase the total supply in cap accordingly.

`public fun mint<T>(cap: &mut coin::TreasuryCap<T>, value: u64, ctx: &mut tx_context::TxContext): coin::Coin<T>`
```
│ │ Input Objects                                                                                            │ │
│ ├──────────────────────────────────────────────────────────────────────────────────────────────────────────┤ │
│ │ 0   Imm/Owned Object ID: 0x3d25df1d63e1710e8904af216f1ce72dde2cdbf539d899e6854e6255076801e1              │ │
│ │ 1   Pure Arg: Type: u64, Value: "100000000"                                                              │ │
│ │ 2   Pure Arg: Type: address, Value: "0xadaee10b2fa28751ad046e0bd30404395f3fac424f48856c19e557fa68a5f810" │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 
```
3. Burn token
```
sui client call \
--function burn \
--module energytoken \
--package 0x837adaa63169334c880ccb3708668ba378b5e10f2f02e1fd3b9a39d630a14370 \
--args 0x3d25df1d63e1710e8904af216f1ce72dde2cdbf539d899e6854e6255076801e1 0xa06b8af2a21e71d4726410c15d6333a02f449ca590403003f751169bbb6cfc6f \
--gas-budget 100000000
```

`0xa06b8af2a21e71d4726410c15d6333a02f449ca590403003f751169bbb6cfc6f` is the object id to be burned.

