![gorucu logo](https://cl2021.vercel.app/img/icon.10a440eb.png "Gorucu Logo")

# Gorucu 

## Auto-invest on crops based on Rainfall

Gorucu is a proof of concept contract + web app that can fetch rainfall data from a chainlink oracle and use this data to auto-invest on certain crops.

This can allow farmers to hedge their harvest income or investors to speculate on rain-dependant farming crop yields with accurate information sourced from oracles.

Preview at: [https://cl2021.vercel.app](https://cl2021.vercel.app/)
Currently running on Kovan testnet only.

### Build and Run:

1. Compile and deploy contracts at /contracts folder. Fund the consumer contracts with LINK tokens.

2. Build and run the vue.js app.

```
$ git clone <this repository>
$ npm i
$ npm run serve
```

