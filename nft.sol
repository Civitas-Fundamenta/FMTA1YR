// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract FMTA1YR is AccessControlEnumerable, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("FMTA1YR", "1YR") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant EDIT_URI_ROLE = keccak256("EDIT_URI_ROLE");

    function mint1YR(address recipient, string memory tokenURI) public returns (uint256) {
        require(hasRole(MINTER_ROLE, msg.sender), "FMTA1YR: Message Sender requires MINTER_ROLE");
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
    
    function setTokenURI (uint256 tokenId, string memory _tokenURI) public {
        require(hasRole(EDIT_URI_ROLE, msg.sender), "FMTA1YR: Message Sender requires EDIT_URI_ROLE");
        _setTokenURI(tokenId, _tokenURI);
    }
    
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}