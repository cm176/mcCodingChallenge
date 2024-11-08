//
//  CryptoMockJSON.swift
//  mcCodingChallengeTests
//
//  Created by Gloomy on 8/11/2024.
//

import Foundation

let cryptoMockJSON = """
[{
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    "current_price": 76020,
    "market_cap": 1503451153562,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1596244252482,
    "total_volume": 64309111767,
    "high_24h": 76873,
    "low_24h": 74444,
    "price_change_24h": 681,
    "price_change_percentage_24h": 0.9039,
    "market_cap_change_24h": 13795382910,
    "market_cap_change_percentage_24h": 0.92608,
    "circulating_supply": 19779225,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 76873,
    "ath_change_percentage": -1.17925,
    "ath_date": "2024-11-07T20:21:22.145Z",
    "atl": 67.81,
    "atl_change_percentage": 111929.51039,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-11-08T01:52:46.113Z"
  },
  {
    "id": "ethereum",
    "symbol": "eth",
    "name": "Ethereum",
    "image": "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
    "current_price": 2912.1,
    "market_cap": 350576106531,
    "market_cap_rank": 2,
    "fully_diluted_valuation": 350578573553,
    "total_volume": 36323475155,
    "high_24h": 2947.84,
    "low_24h": 2787.5,
    "price_change_24h": 102.48,
    "price_change_percentage_24h": 3.64739,
    "market_cap_change_24h": 12021401574,
    "market_cap_change_percentage_24h": 3.5508,
    "circulating_supply": 120419290.028944,
    "total_supply": 120420137.425969,
    "max_supply": null,
    "ath": 4878.26,
    "ath_change_percentage": -40.39986,
    "ath_date": "2021-11-10T14:24:19.604Z",
    "atl": 0.432979,
    "atl_change_percentage": 671399.35695,
    "atl_date": "2015-10-20T00:00:00.000Z",
    "roi": {
      "times": 50.20594654571479,
      "currency": "btc",
      "percentage": 5020.594654571479
    },
    "last_updated": "2024-11-08T01:52:42.279Z"
  },
  {
    "id": "tether",
    "symbol": "usdt",
    "name": "Tether",
    "image": "https://coin-images.coingecko.com/coins/images/325/large/Tether.png?1696501661",
    "current_price": 1,
    "market_cap": 121951089263,
    "market_cap_rank": 3,
    "fully_diluted_valuation": 121951089263,
    "total_volume": 94998190805,
    "high_24h": 1.004,
    "low_24h": 0.99639,
    "price_change_24h": 0.00057927,
    "price_change_percentage_24h": 0.05794,
    "market_cap_change_24h": 660343376,
    "market_cap_change_percentage_24h": 0.54443,
    "circulating_supply": 121953737784.446,
    "total_supply": 121953737784.446,
    "max_supply": null,
    "ath": 1.32,
    "ath_change_percentage": -24.47867,
    "ath_date": "2018-07-24T00:00:00.000Z",
    "atl": 0.572521,
    "atl_change_percentage": 74.5297,
    "atl_date": "2015-03-02T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-11-08T01:52:47.271Z"
  },
  {
    "id": "solana",
    "symbol": "sol",
    "name": "Solana",
    "image": "https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756",
    "current_price": 198.55,
    "market_cap": 93906227577,
    "market_cap_rank": 4,
    "fully_diluted_valuation": 117081079116,
    "total_volume": 6179362212,
    "high_24h": 200.21,
    "low_24h": 186.16,
    "price_change_24h": 9.02,
    "price_change_percentage_24h": 4.75673,
    "market_cap_change_24h": 4324684330,
    "market_cap_change_percentage_24h": 4.82765,
    "circulating_supply": 471566529.255577,
    "total_supply": 587943095.416218,
    "max_supply": null,
    "ath": 259.96,
    "ath_change_percentage": -23.5026,
    "ath_date": "2021-11-06T21:54:35.825Z",
    "atl": 0.500801,
    "atl_change_percentage": 39608.78473,
    "atl_date": "2020-05-11T19:35:23.449Z",
    "roi": null,
    "last_updated": "2024-11-08T01:52:45.127Z"
  },
  {
    "id": "binancecoin",
    "symbol": "bnb",
    "name": "BNB",
    "image": "https://coin-images.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
    "current_price": 601.66,
    "market_cap": 87908173833,
    "market_cap_rank": 5,
    "fully_diluted_valuation": 87908173833,
    "total_volume": 1198282629,
    "high_24h": 610.25,
    "low_24h": 588.82,
    "price_change_24h": -0.44080033062436996,
    "price_change_percentage_24h": -0.07321,
    "market_cap_change_24h": 37418042,
    "market_cap_change_percentage_24h": 0.04258,
    "circulating_supply": 145887575.79,
    "total_supply": 145887575.79,
    "max_supply": 200000000,
    "ath": 717.48,
    "ath_change_percentage": -15.98857,
    "ath_date": "2024-06-06T14:10:59.816Z",
    "atl": 0.0398177,
    "atl_change_percentage": 1513702.4956,
    "atl_date": "2017-10-19T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-11-08T01:52:46.124Z"
  }]
"""

let cryptoSingleMockJSON = """
[{
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    "current_price": 76020,
    "market_cap": 1503451153562,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1596244252482,
    "total_volume": 64309111767,
    "high_24h": 76873,
    "low_24h": 74444,
    "price_change_24h": 681,
    "price_change_percentage_24h": 0.9039,
    "market_cap_change_24h": 13795382910,
    "market_cap_change_percentage_24h": 0.92608,
    "circulating_supply": 19779225,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 76873,
    "ath_change_percentage": -1.17925,
    "ath_date": "2024-11-07T20:21:22.145Z",
    "atl": 67.81,
    "atl_change_percentage": 111929.51039,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-11-08T01:52:46.113Z"
  }]
"""
