package projects.tanks.client.battlefield.models.battle.jgr {
  import alternativa.types.Long;

  public interface IJuggernautModelBase {
    function bossChanged(param1:Long) : void;
    function bossKilled() : void;
  }
}
