var Ratings = artifact.require("./Rating.sol");

module.exports = function(deployer){
    deployer.deploy(Ratings, ['Star Wars', 'Avatar', 'Inception', 'Revanent', 'Tenet', 'Little Miss Sunshine'], {gas:6700000});
};