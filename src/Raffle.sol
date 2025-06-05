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
// internal & private view & pure functions
// external & public view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @author Mosam Shah.
 * @title Smart Contract Lottery System.
 * @dev Implement VRF2.0 chainlinks.
 * @notice working on foundry base code system.
 */

contract Raffle {
    /* Errors */
    error Raffle__NotEnoughEthEntered();
    error Raffle__NotEnoughTimePassed();

    /* State Variables.*/
    uint256 private immutable i_enternceFee;
    address payable[] private s_players;
    uint256 private immutable i_interval; // 60 seconds
    uint256 private lastTimestamp; // Timestamp of the last winner picked
    /* Events*/
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_enternceFee = entranceFee;
        // @dev The interval is in seconds. for example, if you want the raffle to be drawn every 60 seconds, you would pass 60.
        // If you want the raffle to be drawn every 1 minute, you would pass 60.
        i_interval = interval;
        lastTimestamp = block.timestamp; // Initialize the last timestamp to the current block timestamp
    }

    function enterRaffle() public payable {
        // require(msg.value >= i_enternceFee, "Not enough ETH to enter the raffle"); // String are costly in Solidity, especially in versions 0.8.0 and above.
        // require(msg.value >= i_enternceFee, Raffle__NotEnoughEthEntered()); -> Not applicable in Solidity 0.8.0 and above
        // In all Solidity versions 0.8.0 and above, you can use custom errors for better gas efficiency.
        if (msg.value < i_enternceFee) {
            revert Raffle__NotEnoughEthEntered();
        }
        // Logic to enter the raffle
        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() view public {
        // Logic to pick a winner
        // Need to set the Interval
        if (block.timestamp - lastTimestamp < i_interval) {
            revert Raffle__NotEnoughTimePassed();
        }
    }

    function getEntranceFee() public view returns (uint256) {
        return i_enternceFee;
    }
}
