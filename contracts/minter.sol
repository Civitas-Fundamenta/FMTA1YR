// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./fmtaInterface.sol";
import "./nftInterface.sol";

contract minter is AccessControl {
    
    nftInterface private fmta1yr;
    fmtaInterface private fmta;
    
    function mint (address recipient, string memory _tokenURI) public returns (uint256 newItemId) {
        fmta1yr.mint1YR(recipient, _tokenURI);
        return newItemId;
    }
    
    function setFMTA1YR (nftInterface _fmta1yr) public {
        fmta1yr = _fmta1yr;
    }
    
    function getBalance (address user) public returns (uint256 balance) {
        fmta.balanceOf(user);
        
        return balance;
    }
    
    function setFMTA (fmtaInterface _fmta) public {
        fmta = _fmta;
    }
    
}