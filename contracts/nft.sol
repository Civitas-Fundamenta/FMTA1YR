// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract FMTA1YR is AccessControlEnumerable, ERC721URIStorage, ERC721Enumerable {
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    uint256 public cap;

    constructor() ERC721("FMTA1YR", "1YR") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        cap = 100;
    }

    bytes32 public constant _MINTER_ROLE = keccak256("_MINTER_ROLE");
    bytes32 public constant _EDIT_URI_ROLE = keccak256("_EDIT_URI_ROLE");
    bytes32 public constant _ADMIN = keccak256("_ADMIN");

    function mint1YR(address recipient, string memory _tokenURI) external returns (uint256) {
        require(hasRole(_MINTER_ROLE, msg.sender), "FMTA1YR: Message Sender requires MINTER_ROLE");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, _tokenURI);

        return newItemId;
    }
    
    function setTokenURI (uint256 tokenId, string memory _tokenURI) public {
        require(hasRole(_EDIT_URI_ROLE, msg.sender), "FMTA1YR: Message Sender requires EDIT_URI_ROLE");
        _setTokenURI(tokenId, _tokenURI);
    }
    
    function setCap (uint256 _newCap) public {
        require(hasRole(_ADMIN, msg.sender), "FMTA1YR: Must be ADMIN");
        cap = _newCap;
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
        
         if (from == address(0)) { 
            require(totalSupply() <= 10, "FMTA1YR: Minting Limit Reached!");
         }
    }
    
    function _burn (
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

  
   function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return super.tokenURI(tokenId);
    } 
   
}