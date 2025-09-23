// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Voting.sol";
import "forge-std/Script.sol";

contract DeployVoting is Script {
    function run() external {
        vm.startBroadcast();
        Voting voting = new Voting();
        console.log("Voting deployed at:", address(voting));
        vm.stopBroadcast();
        
    }
}

