package projects.tanks.client.panel.model.profile.userproperties {
  import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;

  public interface IUserPropertiesModelBase {
    function changeCrystal(param1:int) : void;
    function onJoinClan() : void;
    function onLeaveClan() : void;
    function updateGearScore(param1:int) : void;
    function updateRank(param1:int, param2:int, param3:RankBounds, param4:int, param5:Boolean, param6:Boolean) : void;
    function updateScore(param1:int) : void;
    function updateUid(param1:String) : void;
    function updateUserRating(param1:int) : void;
  }
}
