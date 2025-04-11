package projects.tanks.client.battlefield.models.ultimate.effects.titan.generator {
  import alternativa.types.Long;

  public interface ITitanUltimateGeneratorModelBase {
    function coverTank(param1:Long) : void;
    function uncoverTank(param1:Long, param2:Boolean) : void;
  }
}
