// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// To consume price data, your smart contract should reference AggregatorV3Interface,
// which defines the external functions implemented by Data Feeds.
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.00000000
        return uint256(answer * 10000000000); // 1**10 == 10000000000
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        // 3000_000000000000000000 = ETH / USD price
        // 1_000000000000000000 ETH

        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // 3000 USD
        return ethAmountInUsd;
    }
}
