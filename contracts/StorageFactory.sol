// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {SimpleStorage} from "./SimpleStorage.sol";



contract StorageFactory{

    address public ethUsd = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    address public btcEth = 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43;

    SimpleStorage[] public listOfSimpleStorageContract;

    function createSimpleStorageContract() public  {
        SimpleStorage simpleStorage = new SimpleStorage();
        listOfSimpleStorageContract.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address
        // ABI - Application Binary Interface
        SimpleStorage mySimpleStorage = listOfSimpleStorageContract[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage mySimpleStorage = listOfSimpleStorageContract[_simpleStorageIndex];
        return mySimpleStorage.retrieve();
    }

}