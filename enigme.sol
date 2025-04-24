// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Enigme {
    uint256 private offset;
    address private owner;
    mapping(uint256 => bytes32) private dict;
    
    constructor(uint _offset) {
        offset = _offset;
        owner = msg.sender;
    }

    function getStorageAt(uint key) public view returns (bytes32 value) {
        assembly {
            value := sload(key)
        }
    }

    function getFromDict(uint _index) public view returns(bytes32) {
        return dict[_index];
    }

    function setKey(uint256 key, bytes32 value) public {
        if (msg.sender != owner) revert("You are not the owner");

        dict[key + offset] = value;
        offset = offset + 1;
    }
}
