// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract FMTA1YR is AccessControlEnumerable, ERC721URIStorage, ERC721Enumerable {
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("FMTA1YR", "1YR") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant EDIT_URI_ROLE = keccak256("EDIT_URI_ROLE");
    bytes32 public constant ADMIN = keccak256("ADMIN");

    function mint1YR(address recipient, string memory _tokenURI) public returns (uint256) {
        require(hasRole(MINTER_ROLE, msg.sender), "FMTA1YR: Message Sender requires MINTER_ROLE");
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, _tokenURI);

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
        override(AccessControlEnumerable, ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    
    function _burn (
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

  
   function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        //string memory baseURI = _baseURI();
        //return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";

        return super.tokenURI(tokenId);
    } 
   
}