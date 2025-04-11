package projects.tanks.clients.flash.commons.models.challenge.shopitems {
  import platform.client.fp10.core.type.IGameObject;

  public interface ChallengeShopItems {
    function get battlePass() : IGameObject;
    function set battlePass(param1:IGameObject) : void;
    function get starsBundle() : IGameObject;
    function set starsBundle(param1:IGameObject) : void;
  }
}
