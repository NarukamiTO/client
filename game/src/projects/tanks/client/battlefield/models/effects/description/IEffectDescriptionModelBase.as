package projects.tanks.client.battlefield.models.effects.description {
  public interface IEffectDescriptionModelBase {
    function activated(param1:int) : void;
    function deactivated() : void;
    function merged(param1:int) : void;
  }
}
