package alternativa.tanks.servermodels {
  [ModelInterface]
  public interface IEntrance {
    function currentState(param1:ILeavableEntranceState) : void;
    function decideWhereToGoAfterStandAloneCaptcha(param1:ILeavableEntranceState, param2:Boolean) : void;
    function antiAddiction() : Boolean;
  }
}
