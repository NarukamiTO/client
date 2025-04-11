package projects.tanks.client.tanksservices.model.reconnect {
  public interface IReconnectModelBase {
    function reconnectFast(param1:RemoteEndpointData) : void;
    function serverReadyToReconnect() : void;
    function setSingleEntranceHash(param1:String) : void;
  }
}
