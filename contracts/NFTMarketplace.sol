// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
    
contract NFTMarketplace is ERC721URIStorage {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    address payable  public owner;
    uint256 listPrice = 0.01 ether;

    struct ListedToken {
        // uint256 tokenId;
        address payable owner;
        address payable seller;
        uint256 price;
        bool currentlyListed;
    }

    mapping(uint256 => ListedToken) private idToListedToken;

    event TokenListedSuccess (
        uint256 indexed tokenId,
        address owner,
        address seller,
        uint256 price,
        bool currentlyListed
    );

    constructor() ERC721("NFTMarketPlace", "NFTM") {
        owner = payable(msg.sender);
    }

    function createToken(string memory tokenURI, uint256 price) public payable returns (uint256 newTokenId) {
        _tokenIds.increment();
        newTokenId = _tokenIds.current();

        _safeMint(msg.sender, newTokenId);

        _setTokenURI(newTokenId, tokenURI);

        createListedToken(newTokenId, price);

        return newTokenId;
    }

    function createListedToken(uint256 tokenId, uint256 price) private {
        require(msg.value == listPrice, "Hopefully sending the correct price");
        require(price > 0, "Make sure the price isn't negative");

        idToListedToken[tokenId] = ListedToken(
            // tokenId,
            payable(address(this)),
            payable(msg.sender),
            price,
            true
        );

        _transfer(msg.sender, address(this), tokenId);
        //Emit the event for successful transfer. The frontend parses this message and updates the end user
        emit TokenListedSuccess(
            tokenId,
            address(this),
            msg.sender,
            price,
            true
        );
    }

    //getters
    function getCurrentToken() public view returns (uint256) {
        return _tokenIds.current();
    }

}