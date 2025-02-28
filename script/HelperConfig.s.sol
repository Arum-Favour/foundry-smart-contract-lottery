//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.s.sol";

abstract contract CodeConstants {
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 1115511;
}
contract HelperConfig is CodeConstants, Script {
    struct NetworkConfig {
        uint256 entranceFee;
        uint256 interval;
        address vrfCoordinator;
        bytes32 gasLane;
        uint32 callbackGasLimit;
        uint256 subscriptionId;
    }

    NetworkConfig public localNetworkConfig;
    mapping(uint256 chainId => NetworkConfig) public networkConfigs;

    constructor() {
        networkConfigs[1115511] = getSepoliaEthConfig();
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                entranceFee: 0.1 ether,
                interval: 30 days,
                vrfCoordinator: 0x8C7382F9D8f56b33781fE506E897a4F1e2d17255,
                gasLane: 0x8C7382F9D8f56b33781fE506E897a4F1e2d17255,
                callbackGasLimit: 500000,
                subscriptionId: 0
            });
    }
}
