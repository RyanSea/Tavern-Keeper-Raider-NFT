//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Raider is ERC721URIStorage, Ownable {

    struct Attributes {

        address _address;
        uint raider_id;          //Raider NFT ID
        string primary_skill;    
        string secondary_skill;  
        string[] achievements;    //List of Achievements (e.g. Raids)
        uint[] achievement_ids;  //Achievement NFT ID's
        
    }
    //Discord ID => Attributes
    mapping(uint => Attributes) public Raiders;
    //Raider NFT ID counter
    uint public id = 1;
    //Achievement NFT ID Counter
    uint public achievement_id = 1;

    event RaiderMinted(
        uint256 indexed discord_id, 
        address indexed user , 
        uint256 indexed nft_id
    );
    event NewAchievement(
        uint indexed discord_id, 
        string achievement
    );
    event AchievementMinted(
        uint indexed discord_id, 
        address indexed user, 
        uint256 indexed nft_id, 
        string achievement
    );

    constructor() ERC721("Raid Guild Profile","RAIDER") {}

    //Initializes Attribute Struct with attributes, maps to Discord ID, and mints RAIDER
    function createProfile (
        uint discord_id, 
        string calldata primary, 
        string calldata secondary, 
        address _address, 
        string calldata metadata
        ) public onlyOwner {

        Attributes memory raider;
        raider.primary_skill = primary;
        raider.secondary_skill = secondary;
        raider._address = _address;
        raider.raider_id = id;

        _mint(
            _address,
            id
        );
        _setTokenURI(
            id, 
            metadata
        );

        Raiders[discord_id] = raider;

        emit RaiderMinted(
            discord_id, 
            Raiders[discord_id]._address, 
            id
        );
        id++;
    }

    //Mints achievment NFT + adds achievement to attribute
    function mintAchievement (
        uint discord_id, 
        string calldata achievement, 
        string calldata metadata
        ) public onlyOwner {

        Raiders[discord_id].achievements.push(achievement);
        Raiders[discord_id].achievement_ids.push(achievement_id);
        
        _mint(
            Raiders[discord_id]._address, 
            achievement_id
        );
        _setTokenURI(
            achievement_id, 
            metadata
        );

        emit AchievementMinted(
            discord_id, 
            Raiders[discord_id]._address, 
            achievement_id, 
            achievement
        );
        achievement_id++;
    }

    //Adds acheivement to attribute (for achievements that aren't worth an NFT)
    function addAchievement (
        uint discord_id, 
        string calldata achievement
        ) public onlyOwner {

        Raiders[discord_id].achievements.push(achievement);

        emit NewAchievement(
            discord_id, 
            achievement
        );
    }

    function changeMetadata (
        uint nft_id, 
        string calldata new_metadata
        ) public onlyOwner {

        _setTokenURI(
            nft_id, 
            new_metadata
        );

    }

    //Unable to view array within struct for strut view call, so this requires its own function
    function viewAchievements (
        uint discord_id
        ) public view  returns (string[] memory) {

        return Raiders[discord_id].achievements;

    }

}