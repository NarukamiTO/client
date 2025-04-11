package alternativa.tanks.servermodels {
  public interface IEntranceStateSwitcher {
    function goToRegistarationState(param1:ILeavableEntranceState) : void;
    function goToLoginByHashState() : void;
    function goToLoginState(param1:ILeavableEntranceState) : void;
  }
}
