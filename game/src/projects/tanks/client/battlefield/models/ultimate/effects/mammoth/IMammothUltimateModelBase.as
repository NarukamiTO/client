package projects.tanks.client.battlefield.models.ultimate.effects.mammoth {
  import alternativa.types.Long;

  public interface IMammothUltimateModelBase {
    function activateField() : void;
    function damageByField(param1:Long) : void;
    function deactivateField() : void;
  }
}
