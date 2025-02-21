// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/**
 *@title  A sample Raffle contract
 *@author Favour Arum
 *@notice This contract is for creating a sample raffle
 *@dev Implements Chainlink VRFv2
 */

contract Raffle {
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    uint256 private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint256 private immutable i_subscriptionId;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee, uint256 interval, address vrfCoordinator, bytes32 gasLane, uint256 subscriptionId) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        i_vrfCoordinator = vrfCoordinator;
        i_gasLane = gasLane;
        s_lastTimeStamp = block.timestamp;
    }
    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH sent!");
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
        //Here we pick a random winner using Chainlink VRF
      uint256  requestId = i_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords;
            })
        );
    }

    /** Getter Function*/

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
