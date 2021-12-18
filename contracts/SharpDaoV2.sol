// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SharpDaoV2 is ERC1155, Ownable {
    // Assign number to act as token ID for Coins, Art etc.
    uint256 public constant COINS = 0;
    uint256 public constant ART = 1;
    // Take index of Proposal and address of voter to find if they have voted.
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    // Mapping for DAO owner address'.
    mapping(address => bool) public isOwner;
    // Proposals to vote on.
    Proposal[] public proposals;
    // List of DAO owners.
    address[] public owners;

    modifier onlyOwners() {
        require(
            isOwner[msg.sender] = true,
            "You need to have ownership for this."
        );
        _;
    }
    // Check that the sender has any nft.
    modifier isNftOwner() {
        require(
            balanceOf(msg.sender, 0) > 0 || balanceOf(msg.sender, 1) > 0,
            "You need NFTs for this."
        );
        _;
    }
    // Typing for the Proposal object
    struct Proposal {
        bytes32 name; // short name (up to 32 bytes),
        uint256 voteCount; // number of accumulated votes, should use counter util in future
    }

    // Pass in the array of owners and base URI
    constructor(address[] memory _owners)
        ERC1155("")
    {
        require(_owners.length > 0, "input of owners required");
        isOwner[msg.sender] = true;
        owners.push(msg.sender);
        for (uint256 i = 0; i < _owners.length; i++) {
            address daoOwner = _owners[i];

            require(
                daoOwner != address(0),
                "invalid owner. cannot be zero address"
            );
            require(!isOwner[daoOwner], "owner not unique");

            isOwner[daoOwner] = true;
            owners.push(daoOwner);
        }
    }

    //Only Owners of the DAO can launch new proposals.
    function newProposal(bytes32 newName) public onlyOwners {
        proposals.push(Proposal({name: newName, voteCount: 0}));
    }

    //onlyNFTOwner can vote,
    function newVote(uint256 index) public isNftOwner {
        require(
            hasVoted[index][msg.sender] != true,
            "You already voted on this proposal"
        );
        // In future, check that I or the NFT artist cannot vote.
        proposals[index].voteCount++;
        hasVoted[index][msg.sender] = true;
    }

    function setBaseURI(string memory newURI) public onlyOwners {
        _setURI(newURI);
    }
    //Check the constant variables in the top of the contract for token IDs
    function mintItem(uint tokenID, uint amount) public onlyOwners {
        _mint(msg.sender, tokenID,  amount, "");
    }
}
