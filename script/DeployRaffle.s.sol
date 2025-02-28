//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.s.sol";
import {Raffle} from "src/Raffle.sol";

contract DeployRaffle is Script {
    function run() {}

    function deployContract() public returns (Raffle, HelperConfig) {}
}
