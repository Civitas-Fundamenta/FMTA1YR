// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

interface nftInterface{
    function mint1YR(address recipient, string memory _tokenURI) external returns (uint256);
}