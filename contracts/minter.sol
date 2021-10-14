// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./fmtaInterface.sol";
import "./nftInterface.sol";

contract minter is AccessControl {
    
    nftInterface private fmta1yr;
    fmtaInterface private fmta;
    
    uint256 public fmtaNeeded;

    string public uri;
    
    mapping (address => bool) public hasMinted;
    
    bytes32 public constant _ADMIN = keccak256("_ADMIN");

    constructor(string memory _tokenURI)
    {
        uri = _tokenURI;
    }
    
    function mint () public returns (uint256) {
        require(getBalance(msg.sender) >= fmtaNeeded, "minter: Account must hold required amount of FMTA");
        require(hasMinted[msg.sender] == false, "minter: FMTA1YR can only be minted once per account");
        uint256 newItemId = fmta1yr.mint1YR(msg.sender, uri);
        hasMinted[msg.sender] = true;
        return newItemId;
    }
    
    function setFMTA1YR (nftInterface _fmta1yr) public {
        require(hasRole(_ADMIN, msg.sender), "minter: Must have ADMIN");
        fmta1yr = _fmta1yr;
    }
    
    function setFMTA (fmtaInterface _fmta) public {
        require(hasRole(_ADMIN, msg.sender), "minter: Must have ADMIN");
        fmta = _fmta;
    }
    
    function setFmtaNeeded (uint256 _NewFmtaNeeded) public {
        require(hasRole(_ADMIN, msg.sender), "minter: Must have ADMIN");
        fmtaNeeded = _NewFmtaNeeded;
    }
    
    function getBalance (address user) public view returns (uint256) {
        uint256 balance = fmta.balanceOf(user);
        return balance;
    }

    function getFMTA() public view returns (fmtaInterface) {
        return fmta;
    }

    function getFMTA1YR() public view returns (nftInterface) {
        return fmta1yr;
    }
}