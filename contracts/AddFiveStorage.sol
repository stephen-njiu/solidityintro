// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { SimpleStorage } from "contracts/SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    // override this fn to add 5 to the default passed value
    function store(uint256 _newNumber) public override {
        favoriteNumber = _newNumber + 5;
    }
}