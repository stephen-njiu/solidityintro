// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19; // version starting from version 19.

contract SimpleStorage {
    uint256 favoriteNumber; // 0

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    //arrays
    Person[] public listOfPeople;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }
    // mappings
    mapping (string => uint256) public nameToFavoriteNumber;

    Person public JJ = Person(7, "JJ");
    Person public KK = Person({favoriteNumber: 8, name: "KK"});

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        Person memory newPerson = Person(_favoriteNumber, _name);
        listOfPeople.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    // calldata, memory, storage
    function addPerson2(string calldata _name, uint256 _favoriteNumber) public {
        Person memory newPerson = Person(_favoriteNumber, _name);
        listOfPeople.push(newPerson);
    }
}



