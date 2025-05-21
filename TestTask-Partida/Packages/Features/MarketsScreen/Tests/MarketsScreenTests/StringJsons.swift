import Foundation

extension String {
    static let singleCurrency: String = """
    {
      "response": {
        "tabs": {
          "BTC": ["BTC"],
          "DeFi": ["DEFI"],
          "USDs": ["USDT"],
          "OTHER": ["OTHER"]
        },
        "currencies": {
          "BTC_USDT": {
            "tabName": "BTC/USDT",
            "pairName": "BTC/USDT",
            "favorite": false,
            "id": 1,
            "isSto": false,
            "stock_icon": null,
            "money_icon": null,
            "stock_label": null,
            "money_label": null,
            "price": "10000",
            "priceUsd": "10000",
            "high": null,
            "change": "5",
            "low": null,
            "volume": "500000",
            "deal": null,
            "priority": 0,
            "min_amount": null,
            "max_amount": null,
            "step_size": null,
            "min_price": null,
            "max_price": null,
            "tick_size": null,
            "min_total": null,
            "stock_precision": 0,
            "money_precision": 0,
            "new": false,
            "zeroFee": false,
            "preDelisting": false
          }
        }
      }
    }
    """

    static let tabs: String = """
    {
      "response": {
        "tabs": {
          "BTC": ["BTC"],
          "DeFi": ["DEFI"],
          "USDs": ["USDT"],
          "OTHER": ["OTHER"]
        },
        "currencies": {}
      }
    }
    """
    
    static let currencies: String = """
        {
          "response": {
            "tabs": {},
            "currencies": {
              "BTC_USDT": {
                "tabName": "BTC/USDT",
                "pairName": "BTC/USDT",
                "favorite": false,
                "id": 1,
                "isSto": false,
                "stock_icon": null,
                "money_icon": null,
                "stock_label": null,
                "money_label": null,
                "price": "10000",
                "priceUsd": "10000",
                "high": null,
                "change": "5",
                "low": null,
                "volume": "500000",
                "deal": null,
                "priority": 0,
                "min_amount": null,
                "max_amount": null,
                "step_size": null,
                "min_price": null,
                "max_price": null,
                "tick_size": null,
                "min_total": null,
                "stock_precision": 0,
                "money_precision": 0,
                "new": false,
                "zeroFee": false,
                "preDelisting": false
              },
              "ETH_USDT": {
                "tabName": "ETH/USDT",
                "pairName": "ETH/USDT",
                "favorite": false,
                "id": 2,
                "isSto": false,
                "stock_icon": null,
                "money_icon": null,
                "stock_label": null,
                "money_label": null,
                "price": "2000",
                "priceUsd": "2000",
                "high": null,
                "change": "2",
                "low": null,
                "volume": "1000000",
                "deal": null,
                "priority": 0,
                "min_amount": null,
                "max_amount": null,
                "step_size": null,
                "min_price": null,
                "max_price": null,
                "tick_size": null,
                "min_total": null,
                "stock_precision": 0,
                "money_precision": 0,
                "new": false,
                "zeroFee": false,
                "preDelisting": false
              }
            }
          }
        }
        """
    static let stats1: String = """
    {
      "period": 86400,
      "last": "100",
      "open": "90",
      "close": "100",
      "high": "110",
      "low": "80",
      "volume": "100000",
      "deal": "10000000"
    }
    """

    static let stats2: String = """
    {
      "period": 86400,
      "last": "200",
      "open": "180",
      "close": "200",
      "high": "210",
      "low": "170",
      "volume": "200000",
      "deal": "40000000"
    }
    """
}
